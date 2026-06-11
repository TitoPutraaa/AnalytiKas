import 'package:anaytikas_frontend/core/shared/models/product_with_details.dart';

class CartItemModels {
  final int idProduct;
  final String namaProduct;
  final int jmlhStok;
  final bool isGrosir;
  final double hargaJual;
  final String satuan;
  int quantity;

  CartItemModels({
    required this.idProduct,
    required this.namaProduct,
    required this.jmlhStok,
    required this.isGrosir,
    required this.hargaJual,
    required this.satuan,
    this.quantity = 0,
  });

  factory CartItemModels.fromMap(ProductWithDetails map) {
    return CartItemModels(
      idProduct: map.product.idProduct,
      namaProduct: map.product.namaProduct,
      jmlhStok: map.product.jmlhStok,
      isGrosir: map.product.isGrosir,
      hargaJual: map.harga.hargaJual,
      satuan: map.harga.satuan,
    );
  }

  double get subtotalHarga => hargaJual * quantity;

  void add() {
    if (quantity <= jmlhStok) {
      quantity += 1;
    }
  }

  void reduce() {
    if (quantity > 0) {
      quantity -= 1;
    }
  }
}
