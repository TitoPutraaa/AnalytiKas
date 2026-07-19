import '../../domain/entitties/toko_entity.dart';

class TokoModel extends TokoEntity {
  TokoModel({
    required super.idToko,
    required super.namaToko,
    required super.email,
    required super.noTelp,
    required super.password,
    required super.alamat,
  });

  factory TokoModel.fromMap(Map<String, dynamic> map) {
    return TokoModel(
      idToko: map['id_toko'] as int,
      namaToko: map['nama_toko'] as String,
      email: map['email'] as String,
      noTelp: map['no_telp'] as String,
      password: map['password'] ?? '',
      alamat: map['alamat'] as String,
    );
  }

  factory TokoModel.fromEntity(TokoEntity entity) {
    return TokoModel(
      idToko: entity.idToko,
      namaToko: entity.namaToko,
      email: entity.email,
      noTelp: entity.noTelp,
      password: entity.password,
      alamat: entity.alamat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_toko': idToko,
      'nama_toko': namaToko,
      'email': email,
      'no_telp': noTelp,
      'password': password,
      'alamat': alamat,
    };
  }
}
