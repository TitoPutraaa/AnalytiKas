import 'package:anaytikas_frontend/core/shared/domain/entitties/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  double totalHarga;
  int quantity;

  CartItemEntity({
    required this.product,
    this.totalHarga = 0,
    this.quantity = 0,
  });

  // factory CartItemEntity.fromProduct(ProductWithDetailsEntity product) {
  //   return CartItemEntity(
  //     idProduct: product.product.idProduct,
  //     namaProduct: product.product.namaProduct,
  //     jmlhStok: product.product.jmlhStok,
  //     hargaJual: product.harga.hargaJual,
  //     satuan: product.harga.satuan,
  //   );
  // }

  void setTotalHarga() {
    totalHarga = product.harga.hargaJual * quantity;
  }

  void add() {
    if (quantity <= product.jmlhStok) {
      quantity += 1;
      setTotalHarga();
    }
  }

  void reduce() {
    if (quantity > 0) {
      quantity -= 1;
      setTotalHarga();
    }
  }
}
