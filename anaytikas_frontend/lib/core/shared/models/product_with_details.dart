import '../entities/harga_entity.dart';
import '../entities/kategori_entity.dart';
import '../entities/produk_entity.dart';
import 'harga_model.dart';
import 'kategori_model.dart';
import 'product_model.dart';

class ProductWithDetails {
  final ProdukEntity product;
  final KategoriEntity kategori;
  final HargaEntity harga;

  ProductWithDetails({
    required this.product,
    required this.kategori,
    required this.harga,
  });

  factory ProductWithDetails.fromMap(Map<String, dynamic> map) {
    return ProductWithDetails(
      product: ProductModel.fromMap(map),
      kategori: KategoriModel.fromMap(map),
      harga: HargaModel.fromMap(map),
    );
  }
}
