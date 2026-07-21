import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class AddBarangBaruException implements Exception {
  final String message;
  const AddBarangBaruException(this.message);

  @override
  String toString() => message;
}

class AddBarangBaru {
  final StokRepository stokRepository;

  AddBarangBaru({required this.stokRepository});

  Future<void> call(Pembelian pembelian, ProductEntity product, int jumlah) {
    if (product.harga.hargaBeli > product.harga.hargaJual) {
      throw AddBarangBaruException(
        "Harga beli tidak boleh lebih besar dari harga jual!",
      );
    }
    if (product.harga.hargaBeli == 0) {
      throw AddBarangBaruException("Harga beli tidak boleh 0");
    }
    if (product.harga.hargaBeli < 0) {
      throw AddBarangBaruException("Harga beli tidak boleh kurang dari 0");
    }
    if (product.harga.hargaJual == 0) {
      throw AddBarangBaruException("Harga jual tidak boleh 0");
    }
    if (product.harga.hargaJual < 0) {
      throw AddBarangBaruException("Harga jual tidak boleh kurang dari 0");
    }

    return stokRepository.addBarangBaru(pembelian, product, jumlah);
  }
}
