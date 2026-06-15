import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';

class ProductPerPembelian {
  final Pembelian pembelian;
  final Product product;

  ProductPerPembelian({required this.pembelian, required this.product});
}
