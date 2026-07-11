import 'harga_entity.dart';
import 'kategori_entity.dart';
import 'produk_entity.dart';

class ProductWithDetailsEntity {
  final ProdukEntity product;
  final KategoriEntity kategori;
  final HargaEntity harga;

  ProductWithDetailsEntity({
    required this.product,
    required this.kategori,
    required this.harga,
  });
}
