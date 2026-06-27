import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/auth_repository.dart';

class GetProfileUsecase {
  final AuthRepository authRepository;

  GetProfileUsecase({required this.authRepository});

  Future<ProfileEntity> call() async {
    return await authRepository.getProfile();
  }
}
