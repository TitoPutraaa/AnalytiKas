import 'package:anaytikas_frontend/core/shared/entities/penjualan_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_per_penjualan_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class SaveTransactionUsecase {
  final KasirRepository repository;
  SaveTransactionUsecase(this.repository);

  Future<void> call(
    PenjualanEntity header,
    List<ProductPerPenjualanEntity> items,
  ) async {
    if (header.totalHarga <= 0) throw Exception('Total Harga tidak boleh 0');
    return await repository.saveTransaction(header, items);
  }
}
