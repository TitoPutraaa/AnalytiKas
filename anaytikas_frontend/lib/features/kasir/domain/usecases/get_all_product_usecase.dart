import '../../../../core/shared/entities/product_with_details_entity.dart';
import '../repositories/kasir_repository.dart';

class GetAllProductUsecase {
  final KasirRepository repository;
  GetAllProductUsecase(this.repository);

  Future<List<ProductWithDetailsEntity>> call() async {
    return await repository.getAllProduct();
  }
}
