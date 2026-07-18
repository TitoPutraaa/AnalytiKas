import 'package:flutter/material.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItemEntity> _items = {};
  Map<int, CartItemEntity> get items => _items;

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

  void addItemToCart(ProductEntity product) {
    _items[product.idProduct] = CartItemEntity(
      product: product,
      totalHarga: 0,
      quantity: 1,
    );
    _items[product.idProduct]!.setTotalHarga();

    notifyListeners();
  }

  void addItem(int idProduct) {
    if (_items[idProduct]!.quantity < _items[idProduct]!.product.jmlhStok) {
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
