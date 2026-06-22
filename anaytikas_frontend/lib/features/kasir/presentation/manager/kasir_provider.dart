import 'package:flutter/material.dart';

import '../../../../core/shared/entities/kategori_entity.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';
import '../../../../core/shared/entities/product_with_details_entity.dart';
import '../../../../core/shared/extensions/datetime_extension.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/get_all_category_usecase.dart';
import '../../domain/usecases/get_all_product_usecase.dart';
import '../../domain/usecases/save_transaction_usecase.dart';

class KasirProvider extends ChangeNotifier {
  final GetAllProductUsecase getAllProduct;
  final GetAllCategoryUsecase getAllCategory;
  final SaveTransactionUsecase saveTransaction;

  KasirProvider({
    required this.getAllProduct,
    required this.saveTransaction,
    required this.getAllCategory,
  });

  List<ProductWithDetailsEntity> _allProducts = [];
  List<ProductWithDetailsEntity> _filteredProduct = [];
  List<KategoriEntity> _allCategory = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorUangPembeli;
  int? _idPenjualan;

  List<ProductWithDetailsEntity> get allProducts => _filteredProduct;
  List<KategoriEntity> get allCategory => _allCategory;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorUangPembeli => _errorUangPembeli;
  int? get idPenjualan => _idPenjualan;

  Future<void> loadProduct() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allProducts = await getAllProduct.call();
      _filteredProduct = _allProducts;
    } catch (e) {
      debugPrint('Data tidak masuk! Error:  $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategory() async {
    try {
      final categories = await getAllCategory.call();
      final allCategory = KategoriEntity(
        idKategori: 0,
        namaKategori: 'Semua Kategori',
      );
      _allCategory = [allCategory, ...categories];
    } catch (e) {
      debugPrint('Kategori tidak masuk! Error:  $e');
    } finally {
      notifyListeners();
    }
  }

  void filterProducts({String query = "", int? categoryId}) {
    final isFiltering =
        query.isNotEmpty || (categoryId != null && categoryId != 0);
    _isSearching = isFiltering;

    final lowerQuery = query.toLowerCase().trim();
    final isCategorySelected = categoryId != null && categoryId != 0;

    _filteredProduct = _allProducts.where((p) {
      if (isCategorySelected && p.product.idKategori != categoryId) {
        return false;
      }

      if (lowerQuery.isNotEmpty) {
        final matchesQuery = p.product.namaProduct.toLowerCase().contains(
          lowerQuery,
        );
        final matchesQueryId = p.product.idProduct.toString().contains(
          lowerQuery,
        );
        return matchesQuery || matchesQueryId;
      }
      return true;
    }).toList();

    notifyListeners();
  }

  ProductWithDetailsEntity? findProductByBarcode(String barcode) {
    final id = int.tryParse(barcode.trim());
    if (id == null) {
      return null;
    }

    for (final p in _allProducts) {
      if (p.product.idProduct == 101) {
        return p;
      }
    }
    return null;
  }

  Future<void> prosesTransaction(
    List<CartItemEntity> cart,
    double uangMasuk,
  ) async {
    _isLoading = true;
    notifyListeners();
    final now = DateTime.now();
    final int totalItems = cart.length;
    final double totalPrices = cart.fold(
      0,
      (sum, item) => sum + item.totalHarga,
    );
    final PenjualanEntity penjualan = PenjualanEntity(
      idPenjualan: 0,
      tanggal: now.toDBDate(),
      waktu: now.toTime(),
      totalItem: totalItems,
      totalHarga: totalPrices,
      uangMasuk: uangMasuk,
    );

    final List<ProductPerPenjualanEntity> detailItems = cart
        .map(
          (item) => ProductPerPenjualanEntity(
            idPenjualan: 0,
            idProduct: item.idProduct,
            jumlah: item.quantity,
          ),
        )
        .toList();
    try {
      _idPenjualan = await saveTransaction.call(penjualan, detailItems);
    } catch (e) {
      debugPrint('Data idPenjualan tidak masuk! $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void validateUangPembeli(String value, {double totalSeluruhHarga = 0}) {
    double uangMasuk = double.tryParse(value) ?? 0.0;
    if (uangMasuk == 0 && value.isEmpty) {
      _errorUangPembeli = 'Uang Pembeli harus diisi!';
    } else if (uangMasuk < totalSeluruhHarga) {
      _errorUangPembeli = 'Uang Pembeli kurang!';
    } else {
      _errorUangPembeli = null;
    }
    notifyListeners();
  }

  void resetSearch() {
    _isSearching = false;
    _filteredProduct = _allProducts;
    notifyListeners();
  }
}
