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

    PenjualanModel penjualan = PenjualanModel(
      idPenjualan: data.first.penjualan.idPenjualan,
      tanggal: data.first.penjualan.tanggal,
      waktu: data.first.penjualan.waktu,
      totalItem: data.first.penjualan.totalItem,
      totalHarga: data.first.penjualan.totalHarga,
    );
    Map<String, dynamic> penjualanMap = penjualan.toMap(includeId: false);
    int newId = await db.transaction((txn) async {
      // 1. Save penjualan
      // print(data);
      int id = await txn.insert('penjualan', penjualanMap);
      // print('id penjualan: $id');
      // 2. Save detail item & update stok
      for (var item in data) {
        // print('data item: $item');
        Map<String, dynamic> itemMap = item.toMap();
        await txn.insert('product_per_penjualan', {
          'id_penjualan': id,
          'id_product': itemMap['id_product'],
          'harga_satuan': itemMap['harga_satuan'],
          'jumlah': itemMap['jumlah'],
        });
        // Less stok barang
        await txn.rawUpdate(
          'UPDATE product set jmlh_stok = jmlh_stok - ? WHERE id_product = ?',
          [itemMap['jumlah'], itemMap['id_product']],
        );
      }

      return id;
    });
    // final data0 = await db.query('product_per_penjualan');
    // final data1 = await db.query('penjualan');
    // final data2 = await db.query('product');
    // print(data0);
    // print(data1);
    // print(data2);
    // print(newId);
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
    print(maps);
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
