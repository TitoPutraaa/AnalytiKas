import '../entities/kategori_entity.dart';

class KategoriModel extends KategoriEntity {
  KategoriModel({required super.idKategori, required super.namaKategori});

  factory KategoriModel.fromMap(Map<String, dynamic> map) {
    return KategoriModel(
      idKategori: map['id_kategori'] as int,
      namaKategori: map['nama_kategori'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id_kategori': idKategori, 'nama_kategori': namaKategori};
  }
}
