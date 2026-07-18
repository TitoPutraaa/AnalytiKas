import '../../domain/entitties/kategori_entity.dart';

class KategoriModel extends KategoriEntity {
  KategoriModel({
    required super.idKategori,
    required super.namaKategori,
    required super.isActive,
  });

  factory KategoriModel.fromMap(Map<String, dynamic> map) {
    return KategoriModel(
      idKategori: map['id_kategori'] as int,
      namaKategori: map['nama_kategori'] as String,
      isActive: map['is_active'] is int
          ? (map['is_active'] as int) == 1
          : (map['is_active'] as bool),
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId) 'id_kategori': idKategori,
      'nama_kategori': namaKategori,
      'is_active': isActive ? 1 : 0,
    };
  }
}
