import '../../../../core/shared/domain/entitties/pembelian_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_pembelian_entity.dart';
import '../repository/stok_repository.dart';

class AddStok {
  final StokRepository stokRepository;

  AddStok({required this.stokRepository});

  Future<void> call(
    PembelianEntity pembelian,
    ProductEntity product,
    int jumlah,
  ) {
    final ProductPerPembelianEntity data = ProductPerPembelianEntity(
      pembelian: pembelian,
      product: product,
      hargaSatuan: product.harga.hargaJual,
      jumlah: jumlah,
    );
    return stokRepository.addStok(data);
  }
}
