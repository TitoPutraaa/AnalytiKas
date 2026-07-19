import '../../../../core/shared/domain/entitties/harga_entity.dart';
import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../repository/stok_repository.dart';

class UpdateProduct {
  final StokRepository stokRepository;

  UpdateProduct({required this.stokRepository});

  Future<void> call(
    int idProduct,
    KategoriEntity kategori,
    HargaEntity harga,
    String namaProduct,
    int jmlhStok,
    int pengingatStok,
    bool isGrosir,
    bool isActive,
  ) {
    final ProductEntity data = ProductEntity(
      idProduct: idProduct,
      namaProduct: namaProduct,
      jmlhStok: jmlhStok,
      isGrosir: isGrosir,
      isActive: isActive,
      pengingatStok: pengingatStok,
      kategori: kategori,
      harga: harga,
    );
    return stokRepository.updateProduct(data);
  }
}
