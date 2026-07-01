import 'package:anaytikas_frontend/core/config/network/connectivity_helper.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/remote_data_source.dart';
import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/repository/analisis_repository.dart';

class AnalisisRepositoryImpl implements AnalisisRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectivityHelper connectivityHelper;

  AnalisisRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivityHelper,
  });
  @override
  Future<AnalisisEntitiy> getAnalisis(String email, String token) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }
    return await remoteDataSource.analitcLaba(email, token);
  }
}
