import 'package:anaytikas_frontend/core/shared/domain/entitties/kategori_entity.dart';
import 'package:anaytikas_frontend/core/shared/domain/entitties/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_products.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class StokHomeProvider with ChangeNotifier {
  final GetAllProducts getAllProduct;
  StokHomeProvider({required this.getAllProduct});

  Status status = Status.initial;
  List<ProductEntity> _allProduct = [];
  List<ProductEntity> _filteredProduct = [];
  final List<KategoriEntity> _allCategory = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String message = "";
  String _searchQuery = "";

  List<ProductEntity> get allProducts => _filteredProduct;
  List<KategoriEntity> get allCategory => _allCategory;
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

  void searchProduct(String query) {
    _searchQuery = query.trim();
    _isSearching = _searchQuery.isNotEmpty;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredProduct = _allProduct;
      return;
    }
    final lowerQuery = _searchQuery.toLowerCase();
    _filteredProduct = _allProduct.where((product) {
      final nameMatch = product.namaProduct.toLowerCase().contains(lowerQuery);
      final idMatch = product.idProduct.toString().contains(lowerQuery);
      return nameMatch || idMatch;
    }).toList();
  }
}
