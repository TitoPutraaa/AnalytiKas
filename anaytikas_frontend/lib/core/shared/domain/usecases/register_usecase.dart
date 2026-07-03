import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';

class RegisterUsecase {
  final AccountRepository repository;
  RegisterUsecase(this.repository);

  // Future<String> call(String email) async {
  //   return await repository.register(email);
  // }

  // Future<String> call2(String email, int otp) async {
  //   return await repository.registerOtp(email, otp);
  // }

  // Future<String> callNewAccount(
  //   String email,
  //   String pass,
  //   String noTelp,
  //   String alamat,
  //   String namaToko,
  // ) async {
  //   return await repository.registerNewAccount(
  //     email,
  //     pass,
  //     noTelp,
  //     alamat,
  //     namaToko,
  //   );
  // }

  // Future<String> callLogin(String email, String pass) async {
  //   return await repository.login(email, pass);
  // }

  // Future<String> callLogout() async {
  //   return await repository.logout();
  // }

  Future<TokoEntity> getToko() async {
    return await repository.getProfile();
  }

  Future<String> syncAllData() async {
    return await repository.syncAllData();
  }
}
