import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class EditProfileUsecase {
  final ProfileRepository profilRepository;

  EditProfileUsecase({required this.profilRepository});

  Future<void> call(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  ) async {
    await profilRepository.editProfile(namaToko, noTelp, alamat, idToko);
  }
}
