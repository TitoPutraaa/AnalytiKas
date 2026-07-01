import 'package:anaytikas_frontend/core/shared/models/pembelian_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/biaya_operasional_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_per_pembelian_model.dart';
import 'package:anaytikas_frontend/features/stok/data/sources/stok_local_datasource.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';
import 'package:sqflite/sqflite.dart';

class StokRepositoryImpl implements StokRepository {
  final StokLocalDatasource datasource;
  StokRepositoryImpl({required this.datasource});

  @override
  Future<void> addBarangBaru(
    Pembelian pembelian,
    ProductEntity product,
    int jumlah,
  ) async {
    try {
      final model = ProductPerPembelianModel(
        pembelian: pembelian,
        product: product,
        jumlah: jumlah,
      );
      return await datasource.addBarangBaruData(model);
    } on DatabaseException catch (e) {
      throw ArgumentError("gagal mengambil produk. err: ${e.toString()}");
    }
  }

  @override
  Future<void> addBiayaOperasional(
    int idBiaya,
    String nama,
    DateTime tanggal,
    DateTime waktu,
    double totalBiaya,
  ) async {
    try {
      final model = BiayaOperasionalModel(
        idBiaya: idBiaya,
        nama: nama,
        tanggal: tanggal,
        totalBiaya: totalBiaya,
        waktu: waktu,
      );
      return await datasource.addBiayaOperasionalData(model);
    } catch (e) {
      throw ArgumentError(
        "gagal menambahkan biaya operasional. err: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> addStok(
    Pembelian pembelian,
    ProductEntity product,
    int jumlah,
  ) async {
    try {
      final model = ProductPerPembelianModel(
        pembelian: pembelian,
        product: product,
        jumlah: jumlah,
      );
      return await datasource.addStokData(model);
    } catch (e) {
      throw ArgumentError("gagal menambahkan stok baru. err: ${e.toString()}");
    }
  }

  @override
  Future<void> updateProduct(
    int idProduct,
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
    bool isGrosir,
    bool isActivate,
  ) async {
    final model = ProductModel(
      idProduct: idProduct,
      kategori: kategori,
      harga: harga,
      namaProduct: namaProduct,
      jmlhStok: jmlhStok,
      stokWarning: stokWarning,
      isActivate: isActivate,
      isGrosir: isGrosir,
    );
    return await datasource.updateProductData(model);
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      return await datasource.getAllProductsData();
    } on DatabaseException catch (e) {
      throw ArgumentError("gagal mengambil produk. err: ${e.toString()}");
    }
  }

  @override
  Future<List<Kategori>> getAllCategory() async {
    try {
      return await datasource.getAllCategory();
    } catch (e) {
      throw ArgumentError(
        "gagal mengambil data kategori Impl. err: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> deleteProduk(ProductEntity updProd) async {
    try {
      await datasource.deleteProduct(updProd);
    } catch (e) {
      throw ArgumentError("gagal menghapus produk. err: ${e.toString()}");
    }
  }
}
