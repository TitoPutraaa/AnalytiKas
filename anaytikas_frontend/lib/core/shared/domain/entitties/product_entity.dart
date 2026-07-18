import 'harga_entity.dart';
import 'kategori_entity.dart';

class ProductEntity {
  final int idProduct;
  final String namaProduct;
  final int jmlhStok;
  final bool isGrosir;
  final bool isActive;
  final int pengingatStok;
  final KategoriEntity kategori;
  final HargaEntity harga;

  ProductEntity({
    required this.idProduct,
    required this.namaProduct,
    required this.jmlhStok,
    required this.isGrosir,
    required this.isActive,
    required this.pengingatStok,
    required this.kategori,
    required this.harga,
  });
}
