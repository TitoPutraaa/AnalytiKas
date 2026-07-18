import 'package:anaytikas_frontend/core/shared/domain/entitties/penjualan_entity.dart';
import 'package:anaytikas_frontend/core/shared/domain/entitties/toko_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_toko_usecase.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/shared/domain/entitties/product_per_penjualan_entity.dart';
import '../../domain/usecases/get_nota_penjualan_usecase.dart';

class NotaPenjualanProvider extends ChangeNotifier {
  final GetNotaPenjualanUsecase getNotaPenjualan;
  final GetTokoUsecase getTokoUsecase;

  NotaPenjualanProvider({
    required this.getNotaPenjualan,
    required this.getTokoUsecase,
  });

  TokoEntity? _toko;
  PenjualanEntity? _penjualan;
  List<ProductPerPenjualanEntity> _notaDetail = [];
  bool _isLoading = false;

  TokoEntity? get toko => _toko;
  PenjualanEntity? get penjualan => _penjualan;
  List<ProductPerPenjualanEntity> get notaDetail => _notaDetail;
  bool get isLoading => _isLoading;

  Future<void> getNotaPenjualanById(int idPenjualan) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('masuk provider');
      _toko = await getTokoUsecase.call();
      print('berhasil ombil toko');
      _notaDetail = await getNotaPenjualan.call(idPenjualan);
      _penjualan = _notaDetail.first.penjualan;
    } catch (e) {
      debugPrint('data penjualan tidak masuk. $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
