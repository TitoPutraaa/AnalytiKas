import 'package:anaytikas_frontend/features/auth/domain/repository/profil_repository.dart';

class LogoutUsecase {
  final ProfilRepository profilRepository;

  LogoutUsecase({required this.profilRepository});

  Future<void> call() async {
    await profilRepository.logout();
  }
}
