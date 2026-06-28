import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profil_repository.dart';

class GetProfileUsecase {
  final ProfilRepository profilRepository;

  GetProfileUsecase({required this.profilRepository});

  Future<ProfileEntity> call() async {
    return await profilRepository.getProfile();
  }
}
