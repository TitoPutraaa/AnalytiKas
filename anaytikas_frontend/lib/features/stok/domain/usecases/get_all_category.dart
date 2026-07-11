import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class GetAllCategory {
  final StokRepository stokRepository;

  GetAllCategory({required this.stokRepository});

  Future<List<Kategori>> call() async {
    return stokRepository.getAllCategory();
  }
}
