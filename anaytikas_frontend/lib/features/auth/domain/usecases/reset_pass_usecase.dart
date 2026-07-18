import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/data/models/api_response.dart';

class ResetPassUsecase {
  final AccountRepository repository;

  ResetPassUsecase(this.repository);

  Future<ApiResponse> call(String email, String pass) async {
    return await repository.resetPass(email, pass);
  }
}
