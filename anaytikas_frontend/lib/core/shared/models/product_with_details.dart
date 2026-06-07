import '../entities/harga_entity.dart';
import '../entities/kategori_entity.dart';
import '../entities/produk_entity.dart';
import 'harga_model.dart';
import 'kategori_model.dart';
import 'product_model.dart';

class ProductWithDetails {
  final ProdukEntity product;
  final KategoriEntity kategori;
  final HargaEntity hargaEceran;
  final HargaEntity? hargaGrosir;

  ProductWithDetails({
    required this.product,
    required this.kategori,
    required this.hargaEceran,
    this.hargaGrosir,
  });

  factory ProductWithDetails.fromMap(Map<String, dynamic> map) {
    return ProductWithDetails(
      product: ProductModel.fromMap(map),
      kategori: KategoriModel.fromMap(map),
      hargaEceran: HargaModel.fromMap(map),
      hargaGrosir: HargaModel(
        idHarga: map['id_harga_grosir'] ?? 0,
        hargaJual: map['harga_jual_grosir'] ?? 0.0,
        hargaBeli: map['harga_beli_grosir'] ?? 0.0,
        satuan: map['satuan_grosir'] ?? '',
        jmlhSatuan: map['jmlh_satuan_grosir'] ?? 0,
      ),
    );
  }
}
