import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';

class AnalisisModel extends AnalisisEntitiy {
  AnalisisModel({
    required super.brutto,
    required super.netto,
    required super.margin,
    required super.presentase,
    required super.tahun,
    required super.totalBiayaOperasional,
    required super.totalPembelian,
    required super.totalPenjualan,
    required super.bulan,
  });

  factory AnalisisModel.fromJson(Map<String, dynamic> json) {
    return AnalisisModel(
      brutto: (json['brutto'] as num).toDouble(),
      netto: (json['netto'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
      presentase: (json['presentase'] as num).toDouble(),
      tahun: json['tahun'] as int,
      totalBiayaOperasional: (json['total_biaya_operasional'] as num)
          .toDouble(),
      totalPembelian: json['total_pembelian'] as int,
      totalPenjualan: json['total_penjualan'] as int,
      bulan: json['bulan'] as String,
    );
  }
}
