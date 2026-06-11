import 'package:flutter/foundation.dart';

import '../../../../core/shared/models/product_with_details.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';
import '../../domain/usecases/get_all_product_usecase.dart';
import '../../domain/usecases/save_transaction_usecase.dart';

class KasirProvider extends ChangeNotifier {
  final GetAllProductUsecase getAllProduct;
  final SaveTransactionUsecase saveTransaction;
  KasirProvider({required this.getAllProduct, required this.saveTransaction});

  List<ProductWithDetails> _allProducts = [];
  List<ProductWithDetails> _filteredProduct = [];
  bool _isLoading = false;

  List<ProductWithDetails> get allProducts => _filteredProduct;
  bool get isLoading => _isLoading;

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

  Future<void> sumbitTransaction(
    PenjualanEntity header,
    List<ProductPerPenjualanEntity> items,
  ) async {
    try {
      await saveTransaction.call(header, items);
    } catch (e) {
      debugPrint('Error:  $e');
    } finally {
      await loadProduct();
    }
  }
}
