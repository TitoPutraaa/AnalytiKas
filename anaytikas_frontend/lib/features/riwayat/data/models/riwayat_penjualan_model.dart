import 'package:anaytikas_frontend/features/riwayat/data/models/transaksi_item_model.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_penjualan_entity.dart';

class RiwayatPenjualanModel extends RiwayatPenjualanEntity {
  RiwayatPenjualanModel({
    required super.idPenjualan,
    required super.tanggal,
    required super.waktu,
    required super.totalItem,
    required super.totalHarga,
    required super.uangMasuk,
    required super.productsTerjual,
    required super.uangkembali,
    required super.namaToko,
    required super.alamat,
  });

  factory RiwayatPenjualanModel.fromMap(List<Map<String, dynamic>> rawData) {
    return RiwayatPenjualanModel(
      idPenjualan: rawData.first['id_penjualan'] as int,
      tanggal: rawData.first['tanggal'] as String,
      waktu: rawData.first['waktu'] as String,
      totalItem: rawData.first['total_item'] as int,
      totalHarga: (rawData.first['total_harga'] as num).toDouble(),
      uangMasuk: (rawData.first['uang_masuk'] as num).toDouble(),
      productsTerjual: rawData
          .map((e) => TransaksiItemModel.fromMap(e))
          .toList(),
      uangkembali: (rawData.first['uang_kembali'] as num).toDouble(),
      namaToko: rawData.first['nama_toko'] as String,
      alamat: rawData.first['alamat'] as String,
    );
  }
}
