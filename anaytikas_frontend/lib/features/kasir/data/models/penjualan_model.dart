import 'package:anaytikas_frontend/features/kasir/data/models/product_per_penjualan_model.dart';
import 'package:anaytikas_frontend/features/kasir/domain/entities/penjualan_entity.dart';

class PenjualanModel extends PenjualanEntity {
  PenjualanModel({
    required super.idPenjualan,
    required super.tanggal,
    required super.waktu,
    required super.totalItem,
    required super.totalHarga,
    required super.uangMasuk,
  });

  factory PenjualanModel.fromMap(
    Map<String, dynamic> map, {
    List<ProductPerPenjualanModel> items = const [],
  }) {
    return PenjualanModel(
      idPenjualan: map['id-penjualan'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total-item'] as int,
      totalHarga: (map['total-harga'] as num).toDouble(),
      uangMasuk: (map['uang-masuk'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id-penjualan': idPenjualan,
      'tanggal': tanggal,
      'waktu': waktu,
      'total-item': totalItem,
      'total-harga': totalHarga,
      'uang-masuk': uangMasuk,
    };
  }
}
