import 'package:anaytikas_frontend/core/shared/domain/entitties/toko_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class GetTokoUsecase {
  final KasirRepository repository;

  GetTokoUsecase(this.repository);

  Future<TokoEntity> call() async {
    return await repository.getToko();
  }
}
