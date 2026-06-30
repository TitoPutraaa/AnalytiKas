import '../../../../core/config/database/database_helper.dart';

abstract class KasirLocalDataSource {
  Future<List<Map<String, dynamic>>> getAllProduct();
  Future<int> saveTransaction(
    Map<String, dynamic> penjualan,
    List<Map<String, dynamic>> items,
  );
  Future<List<Map<String, dynamic>>> getAllCategory();
  Future<int> genereteNextId(String tableName, String idColumn);
  Future<List<Map<String, dynamic>>> getNota(int idPenjualan);
}

class KasirLocalDataSourceImpl implements KasirLocalDataSource {
  final DatabaseHelper dbHelper;
  KasirLocalDataSourceImpl({required this.dbHelper});
  @override
  Future<List<Map<String, dynamic>>> getAllProduct() async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
        SELECT 
          p.id_product, p.nama_product, p.jmlh_stok, p.is_grosir, p.is_active, p.id_kategori, p.id_harga, stok_warning,
          k.id_kategori, k.nama_kategori,
          h.id_harga, h.harga_jual, h.harga_beli, h.satuan 

        FROM product p
        INNER JOIN kategori k ON p.id_kategori = k.id_kategori
        INNER JOIN harga_product h ON p.id_harga = h.id_harga
        
        WHERE p.is_active = 1;
    ''');
  }

  @override
  Future<int> saveTransaction(
    Map<String, dynamic> penjualan,
    List<Map<String, dynamic>> items,
  ) async {
    final db = await dbHelper.database;
    print(items);
    print(penjualan);
    int newId = await db.transaction((txn) async {
      // 1. Save penjualan
      int id = await txn.insert('penjualan', penjualan);
      // 2. Save detail item & update stok
      for (var item in items) {
        await txn.insert('product_per_penjualan', {
          'id_penjualan': id,
          'id_product': item['id_product'],
          'jumlah': item['jumlah'],
        });
        // Less stok barang
        await txn.rawUpdate(
          'UPDATE product set jmlh_stok = jmlh_stok - ? WHERE id_product = ?',
          [item['jumlah'], item['id_product']],
        );
      }
      return id;
    });
    print(newId);
    return newId;
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

  @override
  Future<List<Map<String, dynamic>>> getAllCategory() async {
    final db = await dbHelper.database;
    return await db.query('kategori');
  }

  @override
  Future<List<Map<String, dynamic>>> getNota(int idPenjualan) async {
    final db = await dbHelper.database;
    return await db.rawQuery(
      '''
        SELECT
          p.id_penjualan,
          p.tanggal,
          p.waktu,
          p.total_item,
          p.total_harga,
          pr.nama_product,
          pp.jumlah,
          h.satuan,
          (pp.jumlah * h.harga_jual) AS total_harga_product,
          (SELECT nama_toko FROM toko LIMIT 1) AS nama_toko,
          (SELECT alamat FROM toko LIMIT 1) AS alamat
        FROM penjualan p
        JOIN product_per_penjualan pp ON pp.id_penjualan = p.id_penjualan
        JOIN product pr ON pr.id_product = pp.id_product
        JOIN harga_product h ON h.id_harga = pr.id_harga
        WHERE p.id_penjualan = ?
    ''',
      [idPenjualan],
    );
  }
}
