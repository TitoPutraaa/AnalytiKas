import 'package:anaytikas_frontend/features/kasir/data/models/harga_model.dart';
import 'package:anaytikas_frontend/features/kasir/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/features/kasir/domain/entities/produk_entity.dart';

class ProductModel extends ProdukEntity {
  ProductModel({
    required super.idProduct,
    required super.namaProduct,
    required super.jumlahStok,
    required super.isGrosir,
    required super.isActivate,
    required super.idKategori,
    required super.idHarga,
  });

  factory ProductModel.fromMap(
    Map<String, dynamic> map, {
    HargaModel? harga,
    KategoriModel? namaKategori,
  }) {
    return ProductModel(
      idProduct: map['id-product'] as int,
      namaProduct: map['nama-product'] as String,
      jumlahStok: map['jmlh-stok'] as int,
      isGrosir: (map['is-grosir'] as int) == 1,
      isActivate: (map['is-active'] as int) == 1,
      idKategori: map['id-kategori'] as int,
      idHarga: map['id-harga'] as int,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id-product': idProduct,
      'nama-product': namaProduct,
      'jmlh-stok': jumlahStok,
      'is-grosir': isGrosir ? 1 : 0,
      'is-active': isActivate ? 1 : 0,
      'id-kategori': idKategori,
      'id-harga': idHarga,
    };
  }
}
