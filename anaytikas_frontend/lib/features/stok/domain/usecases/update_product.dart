import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class UpdateProduct {
  final StokRepository stokRepository;

  UpdateProduct({required this.stokRepository});

  Future<void> call(
    String idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  ) {
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
