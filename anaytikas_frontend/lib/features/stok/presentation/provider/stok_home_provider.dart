import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_products.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class StokHomeProvider with ChangeNotifier {
  final GetAllProducts getAllProduct;
  StokHomeProvider({required this.getAllProduct});

  Status status = Status.initial;
  List<ProductEntity> allProduct = [];
  String message = "";

  Future<void> getAllProducts() async {
    status = Status.loading;
    notifyListeners();
    try {
      allProduct = await getAllProduct.call();
      status = Status.success;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = "gagal memuat semua product provider. err: ${e.toString()}";
      notifyListeners();
    }
    notifyListeners();
  }
}
