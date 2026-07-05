import '../entities/produk_entity.dart';

class ProductModel extends ProdukEntity {
  ProductModel({
    required super.idProduct,
    required super.namaProduct,
    required super.jmlhStok,
    required super.isGrosir,
    required super.isActivate,
    required super.idKategori,
    required super.idHarga,
    required super.stokWarning,
  });

  // to read data from sql
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      idProduct: map['id_product'] as int,
      namaProduct: map['nama_product'] as String,
      jmlhStok: map['jmlh_stok'] as int,
      isGrosir: _parseBool(map['is_grosir']),
      isActivate: _parseBool(map['is_active']),
      idKategori: map['id_kategori'] as int,
      idHarga: map['id_harga'] as int,
      stokWarning: map['stok_warning'] as int,
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
      'stok_warning': stokWarning,
    };
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return false;
  }
}
