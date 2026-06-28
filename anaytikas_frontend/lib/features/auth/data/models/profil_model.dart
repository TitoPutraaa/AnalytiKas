import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';

class ProfilModel extends ProfileEntity {
  ProfilModel({
    required super.idToko,
    required super.namaToko,
    required super.email,
    required super.noTelp,
    required super.password,
    required super.alamat,
  });

  factory ProfilModel.fromMap(Map<String, dynamic> map) {
    return ProfilModel(
      idToko: map['id_toko'] as int,
      namaToko: map['nama_toko'] as String,
      email: map['email'] as String,
      noTelp: map['no_telp'] as String,
      password: map['password'] as String,
      alamat: map['alamat'] as String,
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
