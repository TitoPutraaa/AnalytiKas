import 'package:anaytikas_frontend/features/stok/data/models/harga_product_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.idProduct,
    required super.kategori,
    required super.harga,
    required super.namaProduct,
    required super.jmlhStok,
    required super.stokWarning,
    required super.isActivate,
    required super.isGrosir,
  });

  factory ProductModel.fromJoinedMap(Map<String, dynamic> data) {
    Kategori kategori;
    kategori = KategoriModel(
      idKategori: data["id_kategori"] as int,
      namaKategori: data["nama_kategori"] as String,
    );

    HargaProduct hargaProduct;
    hargaProduct = HargaProductModel(
      idHarga: data["id_harga"] as int,
      hargaJual: (data["harga_jual"] as num).toDouble(),
      hargaBeli: (data["harga_beli"] as num).toDouble(),
      satuan: data["satuan"] as String,
    );

    return ProductModel(
      idProduct: data["id_product"] as int,
      kategori: kategori,
      harga: hargaProduct,
      namaProduct: data["nama_product"] as String,
      jmlhStok: data["jmlh_stok"] as int,
      stokWarning: data["stok_warning"] as int,
      isActivate: (data["is_active"] as int) == 1,
      isGrosir: (data["is_grosir"] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_product": idProduct,
      "id_kategori": kategori.idKategori,
      "id_harga": harga.idHarga,
      "nama_product": namaProduct,
      "jmlh_stok": jmlhStok,
      "stok_warning": stokWarning,
      "is_active": isActivate ? 1 : 0,
      "is_grosir": isGrosir ? 1 : 0,
    };
  }
}
