import 'package:intl/intl.dart';
import '../../domain/entitties/penjualan_entity.dart';
import '../../extensions/datetime_extension.dart';

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
      tanggal: DateTime.parse(map['tanggal'] as String),
      waktu: DateFormat('HH:mm:ss').parse(map['waktu'] as String),
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

  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId) 'id_penjualan': idPenjualan,
      'tanggal': tanggal.toDBDate(),
      'waktu': waktu.toTime(),
      'total_item': totalItem,
      'total_harga': totalHarga,
    };
  }
}
