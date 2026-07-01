import '../../entities/toko_entity.dart';

abstract class AccountRepository {
  Future<String> register(String email);
  Future<String> registerOtp(String email, int otp);
  Future<String> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
    String namaToko,
  );
  Future<String> login(String email, String pass);
  Future<String> logout();

  Future<TokoEntity> getProfile();
  Future<String> syncAllData();
}
