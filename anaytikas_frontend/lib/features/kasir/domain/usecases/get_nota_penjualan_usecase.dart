import 'package:anaytikas_frontend/features/kasir/domain/entities/penjualan_detail_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class GetNotaPenjualanUsecase {
  final KasirRepository repository;

  GetNotaPenjualanUsecase(this.repository);

  Future<PenjualanDetailEntity> call(int idPenjualan) async {
    return await repository.getNotaPenjualan(idPenjualan);
  }
}
