import '../../domain/entitties/product_entity.dart';
import 'harga_model.dart';
import 'kategori_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.idProduct,
    required super.namaProduct,
    required super.jmlhStok,
    required super.isGrosir,
    required super.isActive,
    required super.pengingatStok,
    required super.kategori,
    required super.harga,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      idProduct: map['id_product'] as int,
      namaProduct: map['nama_product'] as String,
      jmlhStok: map['jmlh_stok'] as int,

      isGrosir: map['is_grosir'] is int
          ? (map['is_grosir'] as int) == 1
          : (map['is_grosir'] as bool),
      isActive: map['is_active_product'] is int
          ? (map['is_active_product'] as int) == 1
          : (map['is_active_product'] as bool),

      pengingatStok: map['pengingat_stok'] as int,

      kategori: KategoriModel.fromMap({
        'id_kategori': map['id_kategori'],
        'nama_kategori': map['nama_kategori'],
        'is_active': map['is_active_kategori'],
      }),
      harga: HargaModel.fromMap({
        'id_harga': map['id_harga'],
        'harga_jual': map['harga_jual'],
        'harga_beli': map['harga_beli'],
        'satuan': map['satuan'],
      }),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      idProduct: entity.idProduct,
      namaProduct: entity.namaProduct,
      jmlhStok: entity.jmlhStok,
      isGrosir: entity.isGrosir,
      isActive: entity.isActive,
      pengingatStok: entity.pengingatStok,
      kategori: entity.kategori,
      harga: entity.harga,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_product': idProduct,
      'nama_product': namaProduct,
      'jmlh_stok': jmlhStok,
      'is_grosir': isGrosir ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'pengingat_stok': pengingatStok,
      'id_kategori': kategori.idKategori,
      'id_harga': harga.idHarga,
    };
  }
}
