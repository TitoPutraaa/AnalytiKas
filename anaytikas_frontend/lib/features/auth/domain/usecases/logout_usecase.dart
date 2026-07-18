import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/core/shared/data/models/api_response.dart';

class LogoutUsecase {
  final AccountRepository accountRepository;

  LogoutUsecase(this.accountRepository);

  Future<ApiResponse> call() async {
    return await accountRepository.logout();
  }
}
