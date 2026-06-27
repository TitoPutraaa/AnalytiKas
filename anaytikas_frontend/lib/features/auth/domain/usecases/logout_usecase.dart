import 'package:anaytikas_frontend/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> call() async {
    await authRepository.logout();
  }
}
