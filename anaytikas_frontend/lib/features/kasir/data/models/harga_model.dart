import 'package:anaytikas_frontend/features/kasir/domain/entities/harga_entity.dart';

class HargaModel extends HargaEntity {
  HargaModel({
    required super.idHarga,
    required super.hargaJual,
    required super.hargaBeli,
    required super.satuan,
    required super.jumlahSatuan,
  });

  factory HargaModel.fromMap(Map<String, dynamic> map) {
    return HargaModel(
      idHarga: map['id-harga'] as int,
      hargaJual: (map['harga-jual'] as num).toDouble(),
      hargaBeli: (map['harga-beli'] as num).toDouble(),
      satuan: map['satuan'] as String,
      jumlahSatuan: map['jmlh-satuan'] as int,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id-harga': idHarga,
      'harga-jual': hargaJual,
      'harga-beli': hargaBeli,
      'satuan': satuan,
      'jmlh-satuan': jumlahSatuan,
    };
  }
}
