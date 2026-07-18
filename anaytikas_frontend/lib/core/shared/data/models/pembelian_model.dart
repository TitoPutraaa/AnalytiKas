import '../../domain/entitties/pembelian_entity.dart';
import '../../extensions/datetime_extension.dart';
import 'package:intl/intl.dart';

class PembelianModel extends PembelianEntity {
  PembelianModel({
    required super.idPembelian,
    required super.tanggal,
    required super.waktu,
    required super.totalHarga,
  });

  factory PembelianModel.fromMap(Map<String, dynamic> map) {
    return PembelianModel(
      idPembelian: map['id_pembelian'] as int,
      tanggal: DateTime.parse(map['tanggal'] as String),
      waktu: DateFormat('HH:mm:ss').parse(map['waktu'] as String),
      totalHarga: (map['total_harga'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId) 'id_pembelian': idPembelian,
      'tanggal': tanggal.toDBDate(),
      'waktu': waktu.toTime(),
      'total_harga': totalHarga,
    };
  }
}
