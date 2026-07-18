import 'penjualan_entity.dart';
import 'product_entity.dart';

class ProductPerPenjualanEntity {
  final PenjualanEntity penjualan;
  final ProductEntity product;
  final double hargaSatuan;
  final int jumlah;

  ProductPerPenjualanEntity({
    required this.penjualan,
    required this.product,
    required this.hargaSatuan,
    required this.jumlah,
  });
}
