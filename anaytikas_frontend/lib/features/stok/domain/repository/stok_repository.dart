import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';

abstract class StokRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<void> addBarangBaru(
    int idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  );
  Future<void> addBiayaOperasional(
    int idBiaya,
    String nama,
    DateTime tanggal,
    double totalBiaya,
  );
  Future<void> addStok(Pembelian pembelian, ProductEntity product, int jumlah);
  Future<void> updateProduct(
    int idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  );
  Future<List<Kategori>> getAllCategory();
}
