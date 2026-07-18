import 'package:anaytikas_frontend/core/shared/domain/entitties/toko_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository profilRepository;

  GetProfileUsecase({required this.profilRepository});

  Future<TokoEntity> call() async {
    return await profilRepository.getProfile();
  }
}
