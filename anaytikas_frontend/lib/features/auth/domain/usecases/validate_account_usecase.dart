import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';
import 'package:anaytikas_frontend/core/shared/models/api_response.dart';

class ValidateAccountUsecase {
  final AccountRepository repository;

  ValidateAccountUsecase(this.repository);

  Future<ApiResponse> call(TokoEntity toko, int otp) async {
    final email = toko.email;
    final namaToko = toko.namaToko;
    final noTelp = toko.noTelp;
    final alamat = toko.alamat;
    final pass = toko.password;

    await repository.registerOtp(email, otp);
    return await repository.registerNewAccount(
      email,
      pass,
      noTelp,
      alamat,
      namaToko,
    );
  }
}
