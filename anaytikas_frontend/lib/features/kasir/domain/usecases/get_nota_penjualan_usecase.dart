import 'package:anaytikas_frontend/core/shared/domain/entitties/product_per_penjualan_entity.dart';

import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class GetNotaPenjualanUsecase {
  final KasirRepository repository;

  GetNotaPenjualanUsecase(this.repository);

  Future<List<ProductPerPenjualanEntity>> call(int idPenjualan) async {
    return await repository.getNotaPenjualan(idPenjualan);
  }
}
