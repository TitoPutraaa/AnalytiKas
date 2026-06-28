import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';

class RegisterUsecase {
  final AccountRepository repository;
  RegisterUsecase(this.repository);

  Future<String> call(String email) async {
    // print('masuk usecase');
    // return '1';
    return await repository.register(email);
  }
}
