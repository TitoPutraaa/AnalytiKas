import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';

abstract class StokRepository {
  Future<List<Product>> getAllProducts();
  Future<void> addBarangBaru(
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
    String tanggal,
    double totalBiaya,
  );
  Future<void> addStok(Pembelian pembelian, Product product);
  Future<void> updateProduct(
    String idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  );
}
