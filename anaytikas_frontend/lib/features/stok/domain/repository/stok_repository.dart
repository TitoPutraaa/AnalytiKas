import '../../../../core/shared/domain/entitties/biaya_operasional_entity.dart';
import '../../../../core/shared/domain/entitties/kategori_entity.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';
import '../../../../core/shared/domain/entitties/product_per_pembelian_entity.dart';

abstract class StokRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<void> addBarangBaru(ProductPerPembelianEntity data);
  Future<void> addBiayaOperasional(BiayaOperasionalEntity data);
  Future<void> addStok(ProductPerPembelianEntity data);
  Future<void> updateProduct(ProductEntity data);
  Future<List<KategoriEntity>> getAllCategory();
}
