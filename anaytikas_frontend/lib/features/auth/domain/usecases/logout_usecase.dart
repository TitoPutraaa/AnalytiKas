import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class LogoutUsecase {
  final ProfileRepository profilRepository;

  LogoutUsecase({required this.profilRepository});

  Future<void> call() async {
    await profilRepository.logout();
  }
}
