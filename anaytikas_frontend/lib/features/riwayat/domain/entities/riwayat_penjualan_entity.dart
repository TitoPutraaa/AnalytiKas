import 'package:anaytikas_frontend/features/riwayat/domain/entities/transaksi_item_entity.dart';

class RiwayatPenjualanEntity {
  final int idPenjualan;
  final String tanggal;
  final String waktu;
  final int totalItem;
  final double totalHarga;
  final double uangMasuk;
  final List<TransaksiItemEntity> productsTerjual;
  final double uangkembali;
  final String namaToko;
  final String alamat;

  RiwayatPenjualanEntity({
    required this.idPenjualan,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
    required this.uangMasuk,
    required this.productsTerjual,
    required this.uangkembali,
    required this.namaToko,
    required this.alamat,
  });
}
