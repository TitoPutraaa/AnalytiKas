import '../../../../core/shared/entities/penjualan_entity.dart';
import 'penjualan_item_entity.dart';

class PenjualanDetailEntity {
  final PenjualanEntity penjualan;
  final List<PenjualanItemEntity> products;
  final String namaToko;
  final String alamat;

  PenjualanDetailEntity({
    required this.penjualan,
    required this.products,
    required this.namaToko,
    required this.alamat,
  });
}
