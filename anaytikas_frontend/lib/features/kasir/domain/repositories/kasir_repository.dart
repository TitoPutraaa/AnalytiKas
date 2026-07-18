import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_penjualan_entity.dart';
import '../../../../core/shared/domain/entitties/toko_entity.dart';

abstract class KasirRepository {
  Future<List<ProductEntity>> getAllProduct();
  Future<int> saveTransaction(List<ProductPerPenjualanEntity> data);
  Future<List<KategoriEntity>> getAllCategory();
  Future<TokoEntity> getToko();
  Future<List<ProductPerPenjualanEntity>> getNotaPenjualan(int idPenjualan);
}
