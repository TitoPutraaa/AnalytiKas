import '../../domain/entities/penjualan_entity.dart';
import 'product_per_penjualan_model.dart';

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
      idPenjualan: map['id_penjualan'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
      uangMasuk: (map['uang_masuk'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_penjualan': idPenjualan,
      'tanggal': tanggal,
      'waktu': waktu,
      'total_item': totalItem,
      'total_harga': totalHarga,
      'uang_masuk': uangMasuk,
    };
  }
}
