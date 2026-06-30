import '../../entities/toko_entity.dart';

abstract class AccountRepository {
  Future<String> register(String email);
  Future<String> registerOtp(String email, String otp);
  Future<String> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
  );
  Future<String> login(String email, String pass);
  Future<String> logout(String email, String token);
  Future<String> updateProfile(
    String email,
    String token,
    String alamat,
    String noTlp,
  );
  Future<TokoEntity> getProfile(String email, String token);
}
