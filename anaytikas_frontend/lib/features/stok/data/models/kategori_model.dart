import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';

class KategoriModel extends Kategori {
  KategoriModel({required super.idKategori, required super.namaKategori});

  factory KategoriModel.fromMap(Map<String, dynamic> data) {
    return KategoriModel(
      idKategori: data["id_kategori"] as int,
      namaKategori: data["nama_kategori"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"id_kategori": idKategori, "nama_kategori": namaKategori};
  }
}
