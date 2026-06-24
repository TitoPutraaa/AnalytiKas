import 'package:anaytikas_frontend/features/riwayat/data/datasources/riwayat_local_data_source.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_transaksi_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/repositories/riwayat_repository.dart';

class RiwayatRepositoryImpl implements RiwayatRepository {
  final RiwayatLocalDataSource riwayatLocalDataSource;

  RiwayatRepositoryImpl({required this.riwayatLocalDataSource});

  @override
  Future<RiwayatTransaksiEntity> getAllRiwayat(String tanggal) {
    // TODO: implement getAllRiwayat
    throw UnimplementedError();
  }
}
