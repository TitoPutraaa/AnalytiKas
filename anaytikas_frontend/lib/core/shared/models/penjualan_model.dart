import '../entities/penjualan_entity.dart';

class PenjualanModel extends PenjualanEntity {
  PenjualanModel({
    required super.idPenjualan,
    required super.tanggal,
    required super.waktu,
    required super.totalItem,
    required super.totalHarga,
  });

  factory PenjualanModel.fromMap(Map<String, dynamic> map) {
    return PenjualanModel(
      idPenjualan: map['id_penjualan'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
    );
  }

  factory PenjualanModel.fromEntity(PenjualanEntity entity) {
    return PenjualanModel(
      idPenjualan: entity.idPenjualan,
      tanggal: entity.tanggal,
      waktu: entity.waktu,
      totalItem: entity.totalItem,
      totalHarga: entity.totalHarga,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_penjualan': idPenjualan,
      'tanggal': tanggal,
      'waktu': waktu,
      'total_item': totalItem,
      'total_harga': totalHarga,
    };
  }
}
