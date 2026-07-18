import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../repositories/kasir_repository.dart';

class GetAllProductUsecase {
  final KasirRepository repository;
  GetAllProductUsecase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProduct();
  }
}
