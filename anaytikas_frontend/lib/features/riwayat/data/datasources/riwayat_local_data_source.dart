import '../../../../core/config/database/database_helper.dart';

abstract class RiwayatLocalDataSource {
  Future<List<Map<String, dynamic>>> getRiwayatBiayaOperasional();
  Future<List<Map<String, dynamic>>> getRiwayatPenjualan();
  Future<List<Map<String, dynamic>>> getRiwayatPembelian();
}

class RiwayatLocalDataSourceImpl implements RiwayatLocalDataSource {
  final DatabaseHelper dbHelper;

  RiwayatLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<Map<String, dynamic>>> getRiwayatPenjualan() async {
    final db = await dbHelper.database;
    return db.rawQuery('''
      SELECT
        p.id_penjualan,
        p.tanggal,
        p.waktu,
        p.total_item,
        p.total_harga,
        pr.nama_product,
        ppp.jumlah,
        hp.satuan,
        (ppp.jumlah * hp.harga_jual) AS total_harga_per_product,
        (SELECT nama_toko FROM Toko LIMIT 1) AS nama_toko,
        (SELECT alamat FROM Toko LIMIT 1) AS alamat
      FROM penjualan p
      JOIN product_per_penjualan ppp ON ppp.id_penjualan = p.id_penjualan
      JOIN product pr ON pr.id_product = ppp.id_product
      JOIN harga_product hp ON hp.id_harga = pr.id_harga
      ORDER BY p.tanggal DESC, p.waktu DESC
     ''');
  }

  @override
  Future<List<Map<String, dynamic>>> getRiwayatPembelian() async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
      SELECT 
        pb.id_pembelian,
        pb.tanggal,
        pb.waktu,
        pb.total_harga,
        pr.nama_product,
        ppb.jumlah,
        hp.satuan
      FROM Pembelian pb
      JOIN Product_per_Pembelian ppb ON pb.id_pembelian = ppb.id_pembelian
      JOIN Product pr ON ppb.id_product = pr.id_product
      JOIN Harga_product hp ON pr.id_harga = hp.id_harga
      ORDER BY pb.tanggal DESC, pb.waktu DESC
    ''');
  }

  @override
  Future<List<Map<String, dynamic>>> getRiwayatBiayaOperasional() async {
    final db = await dbHelper.database;
    return await db.query(
      'biaya_operasional',
      orderBy: 'tanggal DESC, waktu DESC',
    );
  }
}
