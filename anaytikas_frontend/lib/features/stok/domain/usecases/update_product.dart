import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class UpdateProductException implements Exception {
  final String message;
  const UpdateProductException(this.message);
}

class UpdateProduct {
  final StokRepository stokRepository;

  UpdateProduct({required this.stokRepository});

  Future<void> call(
    int idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  ) {
    if (harga.hargaBeli > harga.hargaJual && isActivate == true) {
      throw UpdateProductException(
        "Harga beli tidak boleh lebih besar dari harga jual!",
      );
    }
    if (harga.hargaBeli == 0 && isActivate == true) {
      throw UpdateProductException("Harga beli tidak boleh 0");
    }
    if (harga.hargaBeli < 0 && isActivate == true) {
      throw UpdateProductException("Harga beli tidak boleh kurang dari 0");
    }
    if (harga.hargaJual == 0 && isActivate == true) {
      throw UpdateProductException("Harga jual tidak boleh 0");
    }
    if (harga.hargaJual < 0 && isActivate == true) {
      throw UpdateProductException("Harga jual tidak boleh kurang dari 0");
    }

    return stokRepository.updateProduct(
      idProduct,
      kategori,
      harga,
      namaProduct,
      jmlhStok,
      stokWarning,
      isGrosir,
      isActivate,
    );
  }
}
