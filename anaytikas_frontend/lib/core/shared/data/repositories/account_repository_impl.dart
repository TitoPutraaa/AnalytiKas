import 'package:anaytikas_frontend/core/shared/data/datasources/token_local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';

import '../../../config/network/connectivity_helper.dart';
import '../../domain/repositories/account_repository.dart';
import '../../models/api_response.dart';
import '../datasources/remote_data_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectivityHelper connectivityHelper;
  final TokenLocalDataSource tokenLocalDataSource;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivityHelper,
    required this.tokenLocalDataSource,
  });

  @override
  Future<String> register(String email) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.register(email);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse.message;
  }

  @override
  Future<String> registerOtp(String email, String otp) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.registerOtp(email, otp);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse.message;
  }

  @override
  Future<String> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
  ) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.registerNewAccount(
      email,
      pass,
      noTelp,
      alamat,
    );
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse.message;
  }

  @override
  Future<String> login(String email, String pass) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.login(email, pass);
    final apiResponse = ApiResponse<String>.fromJson(
      json,
      (data) => data as String,
    );

    if (!apiResponse.success || apiResponse.data == null) {
      throw Exception(apiResponse.message);
    }

    await tokenLocalDataSource.saveToken(apiResponse.data!);
    return apiResponse.message;
  }

  @override
  Future<String> logout(String email, String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<String> updateProfile(
    String email,
    String token,
    String alamat,
    String noTlp,
  ) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<TokoEntity> getProfile(String email, String token) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}
