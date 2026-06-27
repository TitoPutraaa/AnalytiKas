import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_products.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class StokHomeProvider with ChangeNotifier {
  final GetAllProducts getAllProduct;
  StokHomeProvider({required this.getAllProduct});

  Status status = Status.initial;
  List<ProductEntity> _allProduct = [];
  List<ProductEntity> _filteredProduct = [];
  final List<Kategori> _allCategory = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String message = "";

  List<ProductEntity> get allProducts => _filteredProduct;
  List<Kategori> get allCategory => _allCategory;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;

  Future<void> getAllProducts() async {
    status = Status.loading;
    notifyListeners();
    try {
      _isLoading = false;
      _allProduct = await getAllProduct.call();
      _filteredProduct = _allProduct;
      status = Status.success;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = "gagal memuat semua product provider. err: ${e.toString()}";
      notifyListeners();
    }
    notifyListeners();
  }

  void filterProducts({String query = "", int? categoryId}) {
    final isFiltering =
        query.isNotEmpty || (categoryId != null && categoryId != 0);
    _isSearching = isFiltering;

    final lowerQuery = query.toLowerCase().trim();
    final isCategorySelected = categoryId != null && categoryId != 0;

    _filteredProduct = _allProduct.where((p) {
      if (isCategorySelected && p.kategori.idKategori != categoryId) {
        return false;
      }

      if (lowerQuery.isNotEmpty) {
        final matchesQuery = p.namaProduct.toLowerCase().contains(lowerQuery);
        final matchesQueryId = p.idProduct.toString().contains(lowerQuery);
        return matchesQuery || matchesQueryId;
      }
      return true;
    }).toList();

    notifyListeners();
  }
}
