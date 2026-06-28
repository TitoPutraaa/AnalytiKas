import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository profilRepository;

  GetProfileUsecase({required this.profilRepository});

  Future<ProfileEntity> call() async {
    return await profilRepository.getProfile();
  }
}
