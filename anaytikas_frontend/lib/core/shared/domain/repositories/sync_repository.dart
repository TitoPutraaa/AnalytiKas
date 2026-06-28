import 'package:anaytikas_frontend/core/shared/entities/harga_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/pembelian_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/penjualan_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_per_pembelian_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_per_penjualan_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/produk_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/biaya_operasional.dart';

abstract class SyncRepository {
  Future<String> syncAllData(
    String email,
    String token,
    List<BiayaOperasional> biayaOperasi,
    List<ProdukEntity> product,
    List<HargaEntity> hargaProduct,
    List<PembelianEntity> pembelian,
    List<PenjualanEntity> penjualan,
    List<ProductPerPembelianEntity> productPerPembelian,
    List<ProductPerPenjualanEntity> productPerPenjualan,
  );
}
