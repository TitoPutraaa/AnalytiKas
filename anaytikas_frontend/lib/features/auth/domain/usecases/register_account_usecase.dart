import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/data/models/api_response.dart';

class RegisterAccountUsecase {
  final AccountRepository repository;

  RegisterAccountUsecase(this.repository);

  Future<ApiResponse> call(String email) async {
    return await repository.register(email);
  }
}
