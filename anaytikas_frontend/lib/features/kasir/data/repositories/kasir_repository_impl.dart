import '../datasources/kasir_local_data_source.dart';
import '../../../../core/shared/models/penjualan_model.dart';
import '../../../../core/shared/models/product_per_penjualan_model.dart';
import '../../../../core/shared/models/product_with_details.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';
import '../../domain/repositories/kasir_repository.dart';

class KasirRepositoryImpl implements KasirRepository {
  final KasirLocalDataSource localDataSource;

  KasirRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductWithDetails>> getAllProduct() async {
    final rawDraw = await localDataSource.getAllProduct();
    return rawDraw.map((map) => ProductWithDetails.fromMap(map)).toList();
  }

  @override
  Future<void> saveTransaction(
    PenjualanEntity header,
    List<ProductPerPenjualanEntity> items,
  ) async {
    // Konversi Entity ke Map
    final headerMap = (header as PenjualanModel).toMap();
    final itemsMap = items
        .map((item) => (item as ProductPerPenjualanModel).toMap())
        .toList();

    await localDataSource.saveTransaction(headerMap, itemsMap);
  }
}
