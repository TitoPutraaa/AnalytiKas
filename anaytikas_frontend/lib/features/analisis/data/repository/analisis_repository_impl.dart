import 'package:anaytikas_frontend/core/shared/data/datasources/remote_data_source.dart';
import 'package:anaytikas_frontend/core/shared/models/api_response.dart';
import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/repository/analisis_repository.dart';

class AnalisisRepositoryImpl implements AnalisisRepository {
  final RemoteDataSource remoteDataSource;

  AnalisisRepositoryImpl({required this.remoteDataSource});
  @override
  Future<AnalisisEntitiy> getAnalisis(String email, String token) async {
    final datejs = remoteDataSource.analitcLaba(email, token);

    final respose = ApiResponse.fromJson(datejs, (data) => datas);
  }
}
