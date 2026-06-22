import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_biaya_operasi_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_pembelian_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_penjualan_entity.dart';

class RiwayatTransaksiEntity {
  final RiwayatPenjualanEntity penjualan;
  final RiwayatPembelianEntity pembelian;
  final RiwayatBiayaOperasiEntity biayaOperasi;

  RiwayatTransaksiEntity({
    required this.penjualan,
    required this.pembelian,
    required this.biayaOperasi,
  });
}
