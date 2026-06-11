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
        hargaJual: product.harga.hargaJual,
        satuan: product.harga.satuan,
        quantity: 0,
      );
    }
    notifyListeners();
  }

  void reduceItem(int idProduct) {
    if (_items.containsKey(idProduct)) {
      items[idProduct]!.reduce();
    }
    if (_items[idProduct]!.quantity <= 0) {
      items.remove(idProduct);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
