import 'package:anaytikas_frontend/core/shared/models/api_response.dart';

import '../../entities/toko_entity.dart';

abstract class AccountRepository {
  Future<ApiResponse> register(String email);
  Future<ApiResponse> registerOtp(String email, int otp);
  Future<ApiResponse> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
    String namaToko,
  );
  Future<ApiResponse> login(String email, String pass);
  Future<ApiResponse> logout();
  Future<ApiResponse> forgotPass(String email);
  Future<ApiResponse> forgotPassOtp(String email, int otp);
  Future<ApiResponse> resetPass(String email, String pass);

  Future<TokoEntity> getProfile();
  Future<String> syncAllData();
}
