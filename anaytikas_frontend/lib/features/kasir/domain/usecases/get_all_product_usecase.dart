import 'package:anaytikas_frontend/core/shared/models/product_with_details.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class GetAllProductUsecase {
  final KasirRepository repository;
  GetAllProductUsecase(this.repository);

  Future<List<ProductWithDetails>> call() async {
    return await repository.getAllProduct();
  }
}
