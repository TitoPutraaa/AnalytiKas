import '../../../../core/shared/entities/product_with_details_entity.dart';

class CartItemEntity {
  final int idProduct;
  final String namaProduct;
  final int jmlhStok;
  final bool isGrosir;
  final double hargaJual;
  final String satuan;
  double totalHarga;
  int quantity;

  CartItemEntity({
    required this.idProduct,
    required this.namaProduct,
    required this.jmlhStok,
    required this.isGrosir,
    required this.hargaJual,
    required this.satuan,
    this.totalHarga = 0,
    this.quantity = 0,
  });

  factory CartItemEntity.fromProduct(ProductWithDetailsEntity product) {
    return CartItemEntity(
      idProduct: product.product.idProduct,
      namaProduct: product.product.namaProduct,
      jmlhStok: product.product.jmlhStok,
      isGrosir: product.product.isGrosir,
      hargaJual: product.harga.hargaJual,
      satuan: product.harga.satuan,
    );
  }

  void setTotalHarga() {
    totalHarga = hargaJual * quantity;
  }

  void add() {
    if (quantity <= jmlhStok) {
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
