import '../../domain/entities/produk_entity.dart';

class ProductModel extends ProdukEntity {
  ProductModel({
    required super.idProduct,
    required super.namaProduct,
    required super.jmlhStok,
    required super.isGrosir,
    required super.isActivate,
    required super.idKategori,
    required super.idHarga,
  });

  // to read data from sql
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      idProduct: map['id_product'] as int,
      namaProduct: map['nama_product'] as String,
      jmlhStok: map['jmlh_stok'] as int,
      isGrosir: (map['is_grosir'] as int) == 1,
      isActivate: (map['is_active'] as int) == 1,
      idKategori: map['id_kategori'] as int,
      idHarga: map['id_harga'] as int,
    );
  }
  // to send data to sql
  Map<String, dynamic> toMap() {
    return {
      'id_product': idProduct,
      'nama_product': namaProduct,
      'jmlh_stok': jmlhStok,
      'is_grosir': isGrosir ? 1 : 0,
      'is_active': isActivate ? 1 : 0,
      'id_kategori': idKategori,
      'id_harga': idHarga,
    };
  }
}
