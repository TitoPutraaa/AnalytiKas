import '../../../../core/shared/domain/entitties/pembelian_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_pembelian_entity.dart';
import '../repository/stok_repository.dart';

class AddBarangBaru {
  final StokRepository stokRepository;

  AddBarangBaru({required this.stokRepository});

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
    return stokRepository.addBarangBaru(data);
  }
}
