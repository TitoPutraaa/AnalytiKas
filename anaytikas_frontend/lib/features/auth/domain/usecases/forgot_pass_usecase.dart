import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/models/api_response.dart';

class ForgotPassUsecase {
  final AccountRepository repository;

  ForgotPassUsecase(this.repository);
  Future<ApiResponse> call(String email) async {
    return await repository.forgotPass(email);
  }
}
