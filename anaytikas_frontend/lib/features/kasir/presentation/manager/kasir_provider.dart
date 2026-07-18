import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/penjualan_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_penjualan_entity.dart';
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

  List<ProductEntity> _allProducts = [];
  List<ProductEntity> _filteredProduct = [];
  List<KategoriEntity> _allCategory = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorUangPembeli;
  int? _idPenjualan;
  double _uangMasuk = 0.0;
  double _uangKembali = 0.0;

  List<ProductEntity> get allProducts => _filteredProduct;
  List<KategoriEntity> get allCategory => _allCategory;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorUangPembeli => _errorUangPembeli;
  int? get idPenjualan => _idPenjualan;
  double get uangMasuk => _uangMasuk;
  double get uangKembali => _uangKembali;

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
      print('sedang ngambil kategori');
      final categories = await getAllCategory.call();
      print('berhasil');
      final allCategory = KategoriEntity(
        idKategori: 0,
        isActive: true,
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

  ProductEntity? findProductByBarcode(String barcode) {
    final id = int.tryParse(barcode.trim());
    if (id == null) {
      return null;
    }

    for (final p in _allProducts) {
      if (p.idProduct == id) {
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
      tanggal: now,
      waktu: now,
      totalItem: totalItems,
      totalHarga: totalPrices,
    );

    final List<ProductPerPenjualanEntity> dataTransaction = cart
        .map(
          (item) => ProductPerPenjualanEntity(
            penjualan: penjualan,
            product: item.product,
            hargaSatuan: item.product.harga.hargaJual,
            jumlah: item.quantity,
          ),
        )
        .toList();
    try {
      _idPenjualan = await saveTransaction.call(dataTransaction);
      _uangMasuk = uangMasuk;
      _uangKembali = _uangMasuk - totalPrices;
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
