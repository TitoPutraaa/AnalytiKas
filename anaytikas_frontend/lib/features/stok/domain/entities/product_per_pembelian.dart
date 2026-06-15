import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';

class ProductPerPembelian {
  final Pembelian pembelian;
  final ProductEntity product;

  ProductPerPembelian({required this.pembelian, required this.product});
}
