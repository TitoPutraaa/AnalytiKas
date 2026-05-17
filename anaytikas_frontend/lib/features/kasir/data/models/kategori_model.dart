import 'package:anaytikas_frontend/features/kasir/domain/entities/kategori_entity.dart';

class KategoriModel extends KategoriEntity {
  KategoriModel({required super.idKategori, required super.namaKategori});

  factory KategoriModel.fromMap(Map<String, dynamic> map) {
    return KategoriModel(
      idKategori: map['id-kategori'] as int,
      namaKategori: map['nama-kategori'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id-kategori': idKategori, 'nama-kategori': namaKategori};
  }
}
