import 'package:anaytikas_frontend/core/shared/domain/entitties/toko_entity.dart';

abstract class ProfileRepository {
  Future<TokoEntity> getProfile();
  Future<void> editProfile(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  );
  Future<void> logout();
}
