import 'package:anaytikas_frontend/features/auth/domain/repository/profil_repository.dart';

class EditProfileUsecase {
  final ProfilRepository profilRepository;

  EditProfileUsecase({required this.profilRepository});

  Future<void> call(String namaToko, String noTelp, String alamat) async {
    await profilRepository.editProfile(namaToko, noTelp, alamat);
  }
}
