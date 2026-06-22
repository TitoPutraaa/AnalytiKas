import 'package:anaytikas_frontend/core/shared/models/penjualan_model.dart';
import 'package:anaytikas_frontend/features/kasir/data/models/penjualan_item_model.dart';
import 'package:anaytikas_frontend/features/kasir/domain/entities/penjualan_detail_entity.dart';

class PenjualanDetailModel extends PenjualanDetailEntity {
  PenjualanDetailModel({
    required super.penjualan,
    required super.products,
    required super.uangKembali,
    required super.namaToko,
    required super.alamat,
  });

  factory PenjualanDetailModel.fromMap(List<Map<String, dynamic>> rawData) {
    return PenjualanDetailModel(
      penjualan: PenjualanModel.fromMap(rawData.first),
      products: rawData.map((e) => PenjualanItemModel.fromMap(e)).toList(),
      uangKembali: rawData.first['uang_kembali'],
      namaToko: rawData.first['nama_toko'],
      alamat: rawData.first['alamat'],
    );
  }
}
