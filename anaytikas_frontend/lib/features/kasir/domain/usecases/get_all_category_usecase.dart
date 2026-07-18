import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../repositories/kasir_repository.dart';

class GetAllCategoryUsecase {
  final KasirRepository repository;
  GetAllCategoryUsecase(this.repository);

  Future<List<KategoriEntity>> call() async {
    return await repository.getAllCategory();
  }
}
