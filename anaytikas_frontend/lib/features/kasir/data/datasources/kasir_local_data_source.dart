import '../../../../core/config/database/database_helper.dart';

abstract class KasirLocalDataSource {
  Future<List<Map<String, dynamic>>> getAllProduct();
  Future<void> saveTransaction(
    Map<String, dynamic> header,
    List<Map<String, dynamic>> items,
  );
  Future<int> genereteNextId(String tableName, String idColumn);
}

class KasirLocalDataSourceImpl implements KasirLocalDataSource {
  final DatabaseHelper dbHelper;
  KasirLocalDataSourceImpl({required this.dbHelper});
  @override
  Future<List<Map<String, dynamic>>> getAllProduct() async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
        SELECT 
          p.id_product, p.nama_product, p.jmlh_stok, p.is_grosir, p.is_active, p.id_kategori, p.id_harga, warning_stok,
          k.id_kategori, k.nama_kategori,
          h.id_harga, h.harga_jual, h.harga_beli, h.satuan 

        FROM product p
        INNER JOIN kategori k ON p.id_kategori = k.id_kategori
        INNER JOIN harga_product h ON p.id_harga = h.id_harga
        
        WHERE p.is_active = 1;
    ''');
  }

  @override
  Future<void> saveTransaction(
    Map<String, dynamic> header,
    List<Map<String, dynamic>> items,
  ) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      // 1. Save header penjualan
      await txn.insert('penjualan', header);
      // 2. Save detail item & update stok
      for (var item in items) {
        await txn.insert('product_per_penjualan', item);
        // Less stok barang
        await txn.rawUpdate(
          'UPDATE product set jmlh_stok = jmlh_stok - ? WHERE id_product = ?',
          [item['jumlah'], item['id_product']],
        );
      }
    });
  }

  @override
  Future<int> genereteNextId(String tableName, String idColumn) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery(
      'SELECT MAX($idColumn) as max_id FROM $tableName',
    );
    int currentMax = result.first['max_id'] as int? ?? 0;
    return currentMax + 1;
  }
}
