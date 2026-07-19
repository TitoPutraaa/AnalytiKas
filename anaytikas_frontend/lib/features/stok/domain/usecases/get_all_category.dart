import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../repository/stok_repository.dart';

class GetAllCategory {
  final StokRepository stokRepository;

  GetAllCategory({required this.stokRepository});

  Future<List<KategoriEntity>> call() async {
    return stokRepository.getAllCategory();
  }
}
