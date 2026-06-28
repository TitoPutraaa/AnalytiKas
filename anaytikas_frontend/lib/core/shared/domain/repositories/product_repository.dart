import '../../../../features/stok/domain/entities/biaya_operasional.dart';
import '../../entities/harga_entity.dart';
import '../../entities/pembelian_entity.dart';
import '../../entities/penjualan_entity.dart';
import '../../entities/product_per_pembelian_entity.dart';
import '../../entities/product_per_penjualan_entity.dart';
import '../../entities/produk_entity.dart';

abstract class ProductRepository {
  Future<List<ProdukEntity>> getProduct(String email, String token);
  Future<List<HargaEntity>> getHargaProduct(String email, String token);
  Future<List<BiayaOperasional>> getBiayaOp(String email, String token);
  Future<List<PembelianEntity>> getPembelian(String email, String token);
  Future<List<PenjualanEntity>> getPenjualan(String email, String token);
  Future<List<ProductPerPembelianEntity>> getProductPerPembelian(
    String email,
    String token,
  );
  Future<List<ProductPerPenjualanEntity>> getProductPerPenjualn(
    String email,
    String token,
  );
}
