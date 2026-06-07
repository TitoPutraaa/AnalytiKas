import 'package:anaytikas_frontend/features/kasir/data/models/cart_item_models.dart';
import 'package:anaytikas_frontend/core/shared/models/product_with_details.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItemModels> _items = {};
  Map<int, CartItemModels> get items => {..._items};

  void addItem(ProductWithDetails product) {
    if (_items.containsKey(product.product.idProduct)) {
      _items[product.product.idProduct]!.add();
    } else {
      _items[product.product.idProduct] = CartItemModels(
        idProduct: product.product.idProduct,
        namaProduct: product.product.namaProduct,
        jmlhStok: product.product.jmlhStok,
        isGrosir: product.product.isGrosir,
        jmlSatuanEceran: product.hargaEceran.jmlhSatuan,
        hargaEceran: product.hargaEceran.hargaJual,
        jmlSatuanGrosir: product.hargaGrosir?.jmlhSatuan,
        hargaGrosir: product.hargaGrosir?.hargaJual,
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
