import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';

class ProdukEntity {
  final String idProduct;
  final Kategori kategori;
  final HargaProduct harga;
  final String namaProduct;
  final int jmlhStok;
  final int stokWarning;
  final bool isGrosir;
  final bool isActivate;

  ProdukEntity({
    required this.idProduct,
    required this.kategori,
    required this.harga,
    required this.namaProduct,
    required this.jmlhStok,
    required this.stokWarning,
    this.isGrosir = false,
    this.isActivate = true,
  });
}
