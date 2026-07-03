import 'package:anaytikas_frontend/core/config/network/connectivity_helper.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/remote_data_source.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/token_local_data_source.dart';
import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/repository/analisis_repository.dart';

class AnalisisRepositoryImpl implements AnalisisRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final TokenLocalDataSource tokenLocalDataSource;
  final ConnectivityHelper connectivityHelper;

  AnalisisRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivityHelper,
    required this.localDataSource,
    required this.tokenLocalDataSource,
  });
  @override
  Future<AnalisisEntitiy> getAnalisis() async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    String email;
    String? token;
    try {
      email = await localDataSource.getEmail();
      token = await tokenLocalDataSource.getToken();
    } catch (e) {
      throw Exception("gagal mengambil email dan token");
    }
    if (email.isEmpty || token == null) {
      throw Exception('Gagal ambil data toko dari DB');
    }
    return await remoteDataSource.analitcLaba(email, token);
  }
}
