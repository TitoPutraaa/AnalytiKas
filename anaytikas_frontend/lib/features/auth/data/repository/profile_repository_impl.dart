import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRepository profileRepository;

  ProfileRepositoryImpl({required this.profileRepository});

  @override
  Future<void> editProfile(
    String namaToko,
    String noTelp,
    String alamat,
  ) async {
    try {
      await profileRepository.editProfile(namaToko, noTelp, alamat);
    } catch (e) {
      throw ArgumentError(
        "gagal edit profile ke localDb, err: ${e.toString()}",
      );
    }
  }

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      return await profileRepository.getProfile();
    } catch (e) {
      throw ArgumentError(
        "gagal mengambil profile dari localDb, err: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await profileRepository.logout();
    } catch (e) {
      throw ArgumentError("gagal logout, err: ${e.toString()}");
    }
  }
}
