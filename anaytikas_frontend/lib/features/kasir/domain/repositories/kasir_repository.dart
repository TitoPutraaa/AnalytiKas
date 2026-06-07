import '../../../../core/shared/models/product_with_details.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';

abstract class KasirRepository {
  Future<List<ProductWithDetails>> getAllProduct();
  Future<void> saveTransaction(
    PenjualanEntity header,
    List<ProductPerPenjualanEntity> items,
  );
}
