import '../../../../core/config/database/database_helper.dart';

abstract class RiwayatLocalDataSource {
  Future<List<Map<String, dynamic>>> getRiwayatGabunganByTanggal(String tanggal);
  Future<Map<String, dynamic>?> getDetailPenjualan(int idPenjualan);
  Future<Map<String, dynamic>?> getDetailPembelian(int idPembelian);
}

class RiwayatLocalDataSourceImpl implements RiwayatLocalDataSource {
  final DatabaseHelper dbHelper;

  RiwayatLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<Map<String, dynamic>>> getRiwayatGabunganByTanggal(String tanggal) async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
      SELECT
        id_penjualan AS id_transaksi,
        tanggal,
        waktu,
        total_item,
        total_harga,
        uang_masuk,
        'penjualan' AS jenis
      FROM penjualan
      WHERE tanggal = ?
      UNION ALL
      SELECT
        id_pembelian AS id_transaksi,
        tanggal,
        waktu,
        total_item,
        total_harga,
        NULL AS uang_masuk,
        'pembelian' AS jenis
      FROM pembelian
      WHERE tanggal = ?
      ORDER BY waktu ASC
    ''', [tanggal, tanggal]);
  }

  @override
  Future<Map<String, dynamic>?> getDetailPenjualan(int idPenjualan) async {
    final db = await dbHelper.database;
    final headerResult = await db.query(
      'penjualan',
      where: 'id_penjualan = ?',
      whereArgs: [idPenjualan],
    );

    if (headerResult.isEmpty) return null;
    final items = await db.rawQuery('''
      SELECT
        ppp.id_penjualan,
        ppp.id_product,
        ppp.jumlah,
        pr.nama_product,
        pr.jmlh_stok,
        pr.is_grosir,
        k.nama_kategori,
        h.harga_jual,
        h.harga_beli,
        h.satuan,
        h.jmlh_satuan
      FROM product_per_penjualan ppp
      INNER JOIN product pr ON ppp.id_product = pr.id_product
      INNER JOIN kategori k ON pr.id_kategori = k.id_kategori
      INNER JOIN harga_product h ON pr.id_harga = h.id_harga
      WHERE ppp.id_penjualan = ?
    ''', [idPenjualan]);

    return {
      'header': headerResult.first,
      'items': items,
    };
  }

  @override
  Future<Map<String, dynamic>?> getDetailPembelian(int idPembelian) async {
    final db = await dbHelper.database;
    final headerResult = await db.query(
      'pembelian',
      where: 'id_pembelian = ?',
      whereArgs: [idPembelian],
    );

    if (headerResult.isEmpty) return null;
    final items = await db.rawQuery('''
      SELECT
        ppp.id_pembelian,
        ppp.id_product,
        ppp.jumlah,
        pr.nama_product,
        pr.jmlh_stok,
        pr.is_grosir,
        k.nama_kategori,
        h.harga_jual,
        h.harga_beli,
        h.satuan,
        h.jmlh_satuan
      FROM product_per_pembelian ppp
      INNER JOIN product pr ON ppp.id_product = pr.id_product
      INNER JOIN kategori k ON pr.id_kategori = k.id_kategori
      INNER JOIN harga_product h ON pr.id_harga = h.id_harga
      WHERE ppp.id_pembelian = ?
    ''', [idPembelian]);

    return {
      'header': headerResult.first,
      'items': items,
    };
  }
}
