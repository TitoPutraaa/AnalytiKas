import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class GetAllProducts {
  final StokRepository stokRepository;
  GetAllProducts({required this.stokRepository});

  Future<List<ProductEntity>> call() {
    return stokRepository.getAllProducts();
  }
}
