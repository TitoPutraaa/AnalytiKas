import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_transaksi_entity.dart';

abstract class RiwayatRepository {
  Future<RiwayatTransaksiEntity> getAllRiwayat(String tanggal);
}
