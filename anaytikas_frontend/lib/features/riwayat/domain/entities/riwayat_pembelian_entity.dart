import 'package:anaytikas_frontend/features/riwayat/domain/entities/transaksi_item_entity.dart';

class RiwayatPembelianEntity {
  final int idPembelian;
  final String tanggal;
  final String waktu;
  final int totalItem;
  final double totalHarga;
  final List<TransaksiItemEntity> productsTerjual;

  RiwayatPembelianEntity({
    required this.idPembelian,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
    required this.productsTerjual,
  });
}
