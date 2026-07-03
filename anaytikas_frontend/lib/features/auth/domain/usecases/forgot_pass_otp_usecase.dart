import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/models/api_response.dart';

class ForgotPassOtpUsecase {
  final AccountRepository repository;

  ForgotPassOtpUsecase(this.repository);

  Future<ApiResponse> call(String email, int otp) async {
    return await repository.forgotPassOtp(email, otp);
  }
}
