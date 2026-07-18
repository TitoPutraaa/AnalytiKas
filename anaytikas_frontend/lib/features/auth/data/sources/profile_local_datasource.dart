import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/core/shared/data/models/toko_model.dart';

abstract class ProfileLocalDatasource {
  Future<TokoModel> getLocalProfile();
  Future<void> updProfile(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  );
  Future<void> logout();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final DatabaseHelper databaseHelper;

  ProfileLocalDatasourceImpl({required this.databaseHelper});
  @override
  Future<TokoModel> getLocalProfile() async {
    final db = await databaseHelper.database;
    try {
      final result = await db.query('toko', limit: 1);
      return TokoModel.fromMap(result.first);
    } catch (e) {
      throw ArgumentError("Error datasource, err: ${e.toString()}");
    }
  }

  @override
  Future<void> logout() async {
    final db = await databaseHelper.database;
    await db.delete('toko');
  }

  @override
  Future<void> updProfile(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  ) async {
    final db = await databaseHelper.database;
    await db.update(
      "toko",
      {"nama_toko": namaToko, "no_telp": noTelp, "alamat": alamat},
      where: "id_toko = ?",
      whereArgs: [idToko],
    );
  }
}
