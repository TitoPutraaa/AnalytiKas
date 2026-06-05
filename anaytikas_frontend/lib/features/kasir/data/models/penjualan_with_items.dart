import 'package:anaytikas_frontend/features/kasir/domain/entities/penjualan_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/entities/product_per_penjualan_entity.dart';

class PenjualanWithItems {
  final PenjualanEntity penjualan;
  final List<ProductPerPenjualanEntity> items;

  PenjualanWithItems({required this.penjualan, required this.items});
}
