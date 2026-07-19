import 'package:sqflite/sqflite.dart';
import '../../../../core/shared/data/models/biaya_operasional_model.dart';
import '../../../../core/shared/data/models/product_model.dart';
import '../../../../core/shared/data/models/product_per_pembelian_model.dart';
import '../../../../core/shared/domain/entitties/biaya_operasional_entity.dart';
import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_pembelian_entity.dart';
import '../../domain/repository/stok_repository.dart';
import '../sources/stok_local_datasource.dart';

class StokRepositoryImpl implements StokRepository {
  final StokLocalDatasource datasource;
  StokRepositoryImpl({required this.datasource});

  @override
  Future<void> addBarangBaru(ProductPerPembelianEntity data) async {
    try {
      final model = ProductPerPembelianModel.fromEntity(data);
      return await datasource.addBarangBaru(model);
    } on DatabaseException catch (e) {
      throw ArgumentError("gagal mengambil produk. err: ${e.toString()}");
    }
  }

  @override
  Future<void> addBiayaOperasional(BiayaOperasionalEntity data) async {
    try {
      final model = BiayaOperasionalModel.fromEntity(data);
      return await datasource.addBiayaOperasionalData(model);
    } catch (e) {
      throw ArgumentError(
        "gagal menambahkan biaya operasional. err: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> addStok(ProductPerPembelianEntity data) async {
    try {
      final model = ProductPerPembelianModel.fromEntity(data);
      return await datasource.addStokData(model);
    } catch (e) {
      throw ArgumentError("gagal menambahkan stok baru. err: ${e.toString()}");
    }
  }

  @override
  Future<void> updateProduct(ProductEntity data) async {
    final model = ProductModel.fromEntity(data);
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
  Future<List<KategoriEntity>> getAllCategory() async {
    try {
      return await datasource.getAllCategory();
    } catch (e) {
      throw ArgumentError(
        "gagal mengambil data kategori Impl. err: ${e.toString()}",
      );
    }
  }
}
