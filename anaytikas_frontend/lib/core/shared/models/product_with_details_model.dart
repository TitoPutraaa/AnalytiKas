import '../entities/product_with_details_entity.dart';
import 'harga_model.dart';
import 'kategori_model.dart';
import 'product_model.dart';

class ProductWithDetailsModel extends ProductWithDetailsEntity {
  ProductWithDetailsModel({
    required super.product,
    required super.kategori,
    required super.harga,
  });

  factory ProductWithDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductWithDetailsModel(
      product: ProductModel.fromMap(map),
      kategori: KategoriModel.fromMap(map),
      harga: HargaModel.fromMap(map),
    );
  }
}
