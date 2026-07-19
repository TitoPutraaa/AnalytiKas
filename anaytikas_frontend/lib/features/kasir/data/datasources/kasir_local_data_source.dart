import '../../../../core/config/database/database_helper.dart';
import '../../../../core/shared/data/models/kategori_model.dart';
import '../../../../core/shared/data/models/penjualan_model.dart';
import '../../../../core/shared/data/models/product_model.dart';
import '../../../../core/shared/data/models/product_per_penjualan_model.dart';
import '../../../../core/shared/data/models/toko_model.dart';

abstract class KasirLocalDataSource {
  Future<List<ProductModel>> getAllProduct();
  Future<int> saveTransaction(List<ProductPerPenjualanModel> data);
  Future<List<KategoriModel>> getAllCategory();
  Future<TokoModel> getToko();
  Future<List<ProductPerPenjualanModel>> getNota(int idPenjualan);
}

class KasirLocalDataSourceImpl implements KasirLocalDataSource {
  final DatabaseHelper dbHelper;
  KasirLocalDataSourceImpl({required this.dbHelper});
  @override
  Future<List<ProductModel>> getAllProduct() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT 
          p.id_product, p.nama_product, p.jmlh_stok, p.is_grosir, p.is_active AS is_active_product, p.pengingat_stok, 
          k.id_kategori, k.nama_kategori, k.is_active AS is_active_kategori,
          h.id_harga, h.harga_jual, h.harga_beli, h.satuan 

        FROM product p
        INNER JOIN kategori k ON p.id_kategori = k.id_kategori
        INNER JOIN harga_product h ON p.id_harga = h.id_harga
        
        WHERE p.is_active = 1;
    ''');

    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<int> saveTransaction(List<ProductPerPenjualanModel> data) async {
    final db = await dbHelper.database;

    final PenjualanModel penjualanModel = PenjualanModel.fromEntity(
      data.first.penjualan,
    );
    final Map<String, dynamic> penjualanMap = penjualanModel.toMap(
      includeId: false,
    );
    int newId = await db.transaction((txn) async {
      int id = await txn.insert('penjualan', penjualanMap);
      for (var item in data) {
        Map<String, dynamic> itemMap = item.toMap();
        itemMap['id_penjualan'] = id;
        await txn.insert('product_per_penjualan', itemMap);
        // Less stok barang
        await txn.rawUpdate(
          'UPDATE product set jmlh_stok = jmlh_stok - ? WHERE id_product = ?',
          [itemMap['jumlah'], itemMap['id_product']],
        );
      }

      return id;
    });
    return newId;
  }

  @override
  Future<List<KategoriModel>> getAllCategory() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('kategori');
    return maps.map((map) => KategoriModel.fromMap(map)).toList();
  }

  @override
  Future<List<ProductPerPenjualanModel>> getNota(int idPenjualan) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
        SELECT
          p.id_penjualan, p.tanggal, p.waktu, p.total_item, p.total_harga,
          pp.harga_satuan, pp.jumlah,
          pr.id_product, pr.nama_product, pr.jmlh_stok, pr.is_grosir, pr.is_active AS is_active_product, pr.pengingat_stok,
          k.id_kategori, k.nama_kategori, k.is_active AS is_active_kategori,
          h.id_harga, h.harga_jual, h.harga_beli, h.satuan 
        FROM penjualan p
        JOIN product_per_penjualan pp ON pp.id_penjualan = p.id_penjualan
        JOIN product pr ON pr.id_product = pp.id_product
        JOIN harga_product h ON h.id_harga = pr.id_harga
        JOIN kategori k ON k.id_kategori = pr.id_kategori
        WHERE p.id_penjualan = ?
    ''',
      [idPenjualan],
    );
    return maps.map((map) => ProductPerPenjualanModel.fromMap(map)).toList();
  }

  @override
  Future<TokoModel> getToko() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('toko');
    // print(maps);
    return TokoModel.fromMap(maps.first);
  }
}
