import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';

abstract class AuthRepository {
  Future<ProfileEntity> getProfile();
  Future<void> editProfile(String namaToko, String noTelp, String alamat);
  Future<void> logout();
}
