import '../../../../core/shared/domain/entitties/product_per_penjualan_entity.dart';
import '../repositories/kasir_repository.dart';

class SaveTransactionUsecase {
  final KasirRepository repository;
  SaveTransactionUsecase(this.repository);

  Future<int> call(List<ProductPerPenjualanEntity> data) async {
    final idPenjualan = await repository.saveTransaction(data);
    return idPenjualan;
  }
}
