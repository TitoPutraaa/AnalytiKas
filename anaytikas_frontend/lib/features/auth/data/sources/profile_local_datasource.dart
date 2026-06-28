import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/features/auth/data/models/profil_model.dart';
import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';

abstract class ProfileLocalDatasource {
  Future<ProfilModel?> getLocalProfile();
  Future<void> updProfile(ProfileEntity updProfile);
  Future<void> logout();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final DatabaseHelper databaseHelper;

  ProfileLocalDatasourceImpl({required this.databaseHelper});
  @override
  Future<ProfilModel?> getLocalProfile() async {
    final db = await databaseHelper.database;
    final result = await db.query('toko', limit: 1);
    if (result.isEmpty) return null;
    return ProfilModel.fromMap(result.first);
  }

  @override
  Future<void> logout() async {
    final db = await databaseHelper.database;
    await db.delete('toko');
  }

  @override
  Future<void> updProfile(ProfileEntity updProfile) async {
    final db = await databaseHelper.database;
    await db.update(
      "toko",
      {
        "nama_toko": updProfile.namaToko,
        "no_telp": updProfile.noTelp,
        "alamat": updProfile.alamat,
      },
      where: "id_toko = ?",
      whereArgs: [updProfile.idToko],
    );
  }
}
