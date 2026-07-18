import '../../../../core/shared/data/models/product_model.dart';
import '../../../../core/shared/domain/entitties/toko_entity.dart';
import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_penjualan_entity.dart';
import '../../../../core/shared/data/models/product_per_penjualan_model.dart';
import '../../domain/repositories/kasir_repository.dart';
import '../datasources/kasir_local_data_source.dart';

class KasirRepositoryImpl implements KasirRepository {
  final KasirLocalDataSource localDataSource;

  KasirRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductModel>> getAllProduct() async {
    try {
      return await localDataSource.getAllProduct();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> saveTransaction(List<ProductPerPenjualanEntity> data) async {
    List<ProductPerPenjualanModel> dataModel = data
        .map(
          (item) => ProductPerPenjualanModel(
            penjualan: item.penjualan,
            product: item.product,
            hargaSatuan: item.hargaSatuan,
            jumlah: item.jumlah,
          ),
        )
        .toList();
    try {
      int idPenjualan = await localDataSource.saveTransaction(dataModel);
      return idPenjualan;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<KategoriEntity>> getAllCategory() async {
    try {
      return localDataSource.getAllCategory();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductPerPenjualanEntity>> getNotaPenjualan(
    int idPenjualan,
  ) async {
    try {
      print('masuk repo nota');
      final data = await localDataSource.getNota(idPenjualan);
      print('berhasil ambil data repo nota');
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TokoEntity> getToko() async {
    try {
      return await localDataSource.getToko();
    } catch (e) {
      throw Exception(e);
    }
  }
}
