import '../entities/harga_entity.dart';

class HargaModel extends HargaEntity {
  HargaModel({
    required super.idHarga,
    required super.hargaJual,
    required super.hargaBeli,
    required super.satuan,
    required super.jmlhSatuan,
  });

  factory HargaModel.fromMap(Map<String, dynamic> map) {
    return HargaModel(
      idHarga: map['id_harga'] as int,
      hargaJual: (map['harga_jual'] as num).toDouble(),
      hargaBeli: (map['harga_beli'] as num).toDouble(),
      satuan: map['satuan'] as String,
      jmlhSatuan: map['jmlh_satuan'] as int,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id_harga': idHarga,
      'harga_jual': hargaJual,
      'harga_beli': hargaBeli,
      'satuan': satuan,
      'jmlh_satuan': jmlhSatuan,
    };
  }
}
