import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';

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
      idToko: map['id_toko'],
      namaToko: map['nama_toko'],
      email: map['email'],
      noTelp: map['no_telp'],
      password: map['password'] ?? '',
      alamat: map['alamat'],
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
