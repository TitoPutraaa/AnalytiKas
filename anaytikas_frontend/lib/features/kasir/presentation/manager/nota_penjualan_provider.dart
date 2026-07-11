import 'package:flutter/foundation.dart';

import '../../domain/entities/penjualan_detail_entity.dart';
import '../../domain/usecases/get_nota_penjualan_usecase.dart';

class NotaPenjualanProvider extends ChangeNotifier {
  final GetNotaPenjualanUsecase getNotaPenjualan;

  NotaPenjualanProvider({required this.getNotaPenjualan});

  PenjualanDetailEntity? _notaPenjualan;
  bool _isLoading = false;

  PenjualanDetailEntity? get notaPenjualan => _notaPenjualan;
  bool get isLoading => _isLoading;

  Future<void> getNotaPenjualanById(int idPenjualan) async {
    _isLoading = true;
    notifyListeners();

    try {
      _notaPenjualan = await getNotaPenjualan.call(idPenjualan);
    } catch (e) {
      debugPrint('data penjualan tidak masuk. $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
