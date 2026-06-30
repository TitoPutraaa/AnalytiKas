import 'package:anaytikas_frontend/core/shared/entities/penjualan_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_per_penjualan_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class SaveTransactionUsecase {
  final KasirRepository repository;
  SaveTransactionUsecase(this.repository);

  Future<int> call(
    PenjualanEntity penjualan,
    List<ProductPerPenjualanEntity> items,
  ) async {
    if (penjualan.totalHarga <= 0) throw Exception('Total Harga tidak boleh 0');
    final idPenjualan = await repository.saveTransaction(penjualan, items);
    return idPenjualan;
  }
}
