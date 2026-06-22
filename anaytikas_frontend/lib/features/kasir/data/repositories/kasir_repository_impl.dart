import '../../../../core/shared/entities/kategori_entity.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';
import '../../../../core/shared/entities/product_with_details_entity.dart';
import '../../../../core/shared/models/kategori_model.dart';
import '../../../../core/shared/models/penjualan_model.dart';
import '../../../../core/shared/models/product_per_penjualan_model.dart';
import '../../../../core/shared/models/product_with_details_model.dart';
import '../../domain/entities/penjualan_detail_entity.dart';
import '../../domain/repositories/kasir_repository.dart';
import '../datasources/kasir_local_data_source.dart';
import '../models/penjualan_detail_model.dart';

class KasirRepositoryImpl implements KasirRepository {
  final KasirLocalDataSource localDataSource;

  KasirRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductWithDetailsEntity>> getAllProduct() async {
    final rawData = await localDataSource.getAllProduct();
    return rawData.map((map) => ProductWithDetailsModel.fromMap(map)).toList();
  }

  @override
  Future<int> saveTransaction(
    PenjualanEntity penjualan,
    List<ProductPerPenjualanEntity> items,
  ) async {
    final penjualanModel = PenjualanModel.fromEntity(penjualan);
    final penjualanMap = penjualanModel.toMap();
    penjualanMap.remove('id_penjualan'); // to create increment in db.
    // print(penjualanMap);

    final itemsModel = items
        .map((item) => ProductPerPenjualanModel.fromEntity(item))
        .toList();
    final itemsMap = itemsModel.map((item) {
      final map = item.toMap();
      map.remove('id_penjualan');
      return map;
    }).toList();

    final int idPejualan = await localDataSource.saveTransaction(
      penjualanMap,
      itemsMap,
    );
    return idPejualan;
  }

  @override
  Future<List<KategoriEntity>> getAllCategory() async {
    final rawData = await localDataSource.getAllCategory();
    return rawData.map((map) => KategoriModel.fromMap(map)).toList();
  }

  @override
  Future<PenjualanDetailEntity> getNotaPenjualan(int idPenjualan) async {
    final rawData = await localDataSource.getNota(idPenjualan);
    return PenjualanDetailModel.fromMap(rawData);
  }
}
