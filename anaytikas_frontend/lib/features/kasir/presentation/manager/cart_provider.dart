import 'package:flutter/material.dart';

import '../../../../core/shared/entities/product_with_details_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItemEntity> _items = {};
  Map<int, CartItemEntity> get items => Map.unmodifiable(_items);

  bool isProductInCart(int idProduct) {
    return _items.containsKey(idProduct);
  }

  double get totalSeluruhHarga {
    double totalSeluruhHarga = 0;
    for (var item in _items.values) {
      totalSeluruhHarga += item.totalHarga;
    }
    return totalSeluruhHarga;
  }

  void addItemToCart(ProductWithDetailsEntity product) {
    _items[product.product.idProduct] = CartItemEntity(
      idProduct: product.product.idProduct,
      namaProduct: product.product.namaProduct,
      jmlhStok: product.product.jmlhStok,
      isGrosir: product.product.isGrosir,
      hargaJual: product.harga.hargaJual,
      satuan: product.harga.satuan,
      totalHarga: 0,
      quantity: 1,
    );
    _items[product.product.idProduct]!.setTotalHarga();

    notifyListeners();
  }

  void addItem(int idProduct) {
    if (_items[idProduct]!.quantity < _items[idProduct]!.jmlhStok) {
      _items[idProduct]!.add();
    }
    notifyListeners();
  }

  void reduceItem(int idProduct) {
    if (_items.containsKey(idProduct)) {
      _items[idProduct]!.reduce();
      if (_items[idProduct]!.quantity == 0) {
        _items.remove(idProduct);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
