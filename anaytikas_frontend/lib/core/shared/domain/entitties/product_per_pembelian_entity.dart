import 'pembelian_entity.dart';
import 'product_entity.dart';

class ProductPerPembelianEntity {
  final PembelianEntity pembelian;
  final ProductEntity product;
  final double hargaSatuan;
  final int jumlah;

  ProductPerPembelianEntity({
    required this.pembelian,
    required this.product,
    required this.hargaSatuan,
    required this.jumlah,
  });
}
