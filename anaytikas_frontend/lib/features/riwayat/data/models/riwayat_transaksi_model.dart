import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_transaksi_entity.dart';

class RiwayatTransaksiModel extends RiwayatTransaksiEntity {
  RiwayatTransaksiModel({
    required super.penjualan,
    required super.pembelian,
    required super.biayaOperasi,
  });
}
