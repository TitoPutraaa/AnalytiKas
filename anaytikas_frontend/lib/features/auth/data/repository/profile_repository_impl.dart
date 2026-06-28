import 'package:anaytikas_frontend/features/auth/data/sources/profile_local_datasource.dart';
import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDatasource profileLocalDatasource;

  ProfileRepositoryImpl({required this.profileLocalDatasource});

  @override
  Future<void> editProfile(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  ) async {
    try {
      await profileLocalDatasource.updProfile(namaToko, noTelp, alamat, idToko);
    } catch (e) {
      throw ArgumentError(
        "gagal edit profile ke localDb, err: ${e.toString()}",
      );
    }
  }

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      return await profileLocalDatasource.getLocalProfile();
    } catch (e) {
      throw ArgumentError(
        "gagal mengambil profile dari localDb, err: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await profileLocalDatasource.logout();
    } catch (e) {
      throw ArgumentError("gagal logout, err: ${e.toString()}");
    }
  }
}
