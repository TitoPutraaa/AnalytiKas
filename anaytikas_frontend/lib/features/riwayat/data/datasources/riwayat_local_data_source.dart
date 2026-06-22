import 'package:anaytikas_frontend/features/riwayat/data/models/riwayat_biaya_operasi_model.dart';
import 'package:anaytikas_frontend/features/riwayat/data/models/riwayat_pembelian_model.dart';
import 'package:anaytikas_frontend/features/riwayat/data/models/riwayat_penjualan_model.dart';

import '../../../../core/config/database/database_helper.dart';

abstract class RiwayatLocalDataSource {
  Future<List<Map<String, dynamic>>> getRiwayatBiayaOperasi();
  Future<List<Map<String, dynamic>>> getRiwayatPembelian();
  Future<List<Map<String, dynamic>>> getRiwayatPenjualan();
}

class RiwayatLocalDataSourceImpl implements RiwayatLocalDataSource {
  final DatabaseHelper dbHelper;

  RiwayatLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<Map<String, dynamic>>> getRiwayatBiayaOperasi() async {
    final db = await dbHelper.database;
    return await db.query('biaya_operasi');
  }

  @override
  Future<List<Map<String, dynamic>>> getRiwayatPembelian() async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
      SELECT 
        p.id_pembelian, 
        p.tanggal, 
        p.waktu, 
        p.total_item, 
        p.total_harga,
        ppb.jumlah,
        pr.nama_product,
        hp.satuan,
        hp.harga_beli
      FROM Pembelian p
      LEFT JOIN [Product-per-Pembelian] ppb ON p.id_pembelian = ppb.id_pembelian
      LEFT JOIN Product pr ON ppb.id_product = pr.id_product
      LEFT JOIN [Harga-product] hp ON pr.id_harga = hp.id_harga
    ''');
  }

  @override
  Future<List<Map<String, dynamic>>> getRiwayatPenjualan() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> rawData = await db.rawQuery('''
      SELECT 
        p.id_penjualan, 
        p.tanggal, 
        p.waktu, 
        p.total_item, 
        p.total_harga, 
        p.uang_masuk,
        (p.uang_masuk - p.total_harga) AS uang_kembali, 
        (ppp.jumlah * hp.harga_jual) AS total_harga_product,   
        (SELECT nama_toko FROM Toko LIMIT 1) AS nama_toko,
        (SELECT alamat FROM Toko LIMIT 1) AS alamat,
        ppp.jumlah,
        pr.nama_product,
        hp.satuan,
        hp.harga_jual
      FROM penjualan p
      JOIN product_per_penjualan ppp ON ppp.id_penjualan = p.id_penjualan
      JOIN product pr ON pr.id_product = ppp.id_product
      JOIN harga_product hp ON hp.id_harga = pr.id_harga
     ''');

    final Map<int, List<Map<String, dynamic>>> groupedMap = {};
    for (final row in rawData) {
      final id = row['id_penjualan'] as int;
      groupedMap.putIfAbsent(id, () => []).add(row);
    }

    // 2. Rekonstruksi struktur Map agar satu ID memiliki satu List internal
    final List<Map<String, dynamic>> hasilAkhir = [];

    for (final entry in groupedMap.entries) {
      final listProdukPerId = entry.value;

      // Ambil data nota dari baris pertama (karena data penjualan p pasti sama)
      final Map<String, dynamic> notaData = Map<String, dynamic>.from(
        listProdukPerId.first,
      );

      // Format ulang: Simpan semua baris produk ke dalam key tersendiri
      // Catatan: Jika menggunakan cara ini, pastikan factory `fromMap` Anda disesuaikan lagi.
      notaData['products_terjual'] = listProdukPerId;

      hasilAkhir.add(notaData);
    }

    return hasilAkhir;
  }
}
