import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class AddStokException implements Exception {
  final String message;
  const AddStokException(this.message);
}

class AddStok {
  final StokRepository stokRepository;

  AddStok({required this.stokRepository});

  Future<void> call(Pembelian pembelian, ProductEntity product, int jumlah) {
    if (product.harga.hargaBeli == 0) {
      throw AddStokException("Harga beli tidak boleh 0");
    }
    if (product.harga.hargaBeli < 0) {
      throw AddStokException("Harga beli tidak boleh kurang dari 0");
    }
    return stokRepository.addStok(pembelian, product, jumlah);
  }
}
