import 'package:anaytikas_frontend/core/shared/entities/kategori_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';

class GetAllCategoryUsecase {
  final KasirRepository repository;
  GetAllCategoryUsecase(this.repository);

  Future<List<KategoriEntity>> call() async {
    return await repository.getAllCategory();
  }
}
