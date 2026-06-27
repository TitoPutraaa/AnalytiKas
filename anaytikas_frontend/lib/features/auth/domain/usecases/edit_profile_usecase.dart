import 'package:anaytikas_frontend/features/auth/domain/repository/auth_repository.dart';

class EditProfileUsecase {
  final AuthRepository authRepository;

  EditProfileUsecase({required this.authRepository});

  Future<void> call(String namaToko, String noTelp, String alamat) async {
    await authRepository.editProfile(namaToko, noTelp, alamat);
  }
}
