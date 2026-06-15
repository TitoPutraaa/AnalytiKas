import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class GetAllProducts {
  final StokRepository stokRepository;
  GetAllProducts({required this.stokRepository});

  Future<List<Product>> call() {
    return stokRepository.getAllProducts();
  }
}
