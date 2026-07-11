import 'package:anaytikas_frontend/core/shared/entities/kategori_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_with_details_entity.dart';
import 'package:anaytikas_frontend/features/kasir/domain/entities/penjualan_detail_entity.dart';
import '../../../../core/shared/entities/penjualan_entity.dart';
import '../../../../core/shared/entities/product_per_penjualan_entity.dart';

abstract class KasirRepository {
  Future<List<ProductWithDetailsEntity>> getAllProduct();
  Future<int> saveTransaction(
    PenjualanEntity penjualan,
    List<ProductPerPenjualanEntity> items,
  );
  Future<List<KategoriEntity>> getAllCategory();
  Future<PenjualanDetailEntity> getNotaPenjualan(int idPenjualan);
}
