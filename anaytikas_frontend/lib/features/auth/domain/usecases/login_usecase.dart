import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/data/models/api_response.dart';

class LoginUsecase {
  final AccountRepository repository;

  LoginUsecase(this.repository);

  Future<ApiResponse> call(String email, String pass) async {
    return await repository.login(email, pass);
  }
}
