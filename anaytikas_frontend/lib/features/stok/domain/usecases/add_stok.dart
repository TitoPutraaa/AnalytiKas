import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class AddStok {
  final StokRepository stokRepository;

  AddStok({required this.stokRepository});

  Future<void> call(Pembelian pembelian, ProductEntity product, int jumlah) {
    return stokRepository.addStok(pembelian, product, jumlah);
  }
}
