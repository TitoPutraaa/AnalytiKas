import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../repository/stok_repository.dart';

class GetAllProducts {
  final StokRepository stokRepository;
  GetAllProducts({required this.stokRepository});

  Future<List<ProductEntity>> call() {
    return stokRepository.getAllProducts();
  }
}
