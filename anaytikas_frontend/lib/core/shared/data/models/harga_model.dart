import '../../domain/entitties/harga_entity.dart';

class HargaModel extends HargaEntity {
  HargaModel({
    required super.idHarga,
    required super.hargaJual,
    required super.hargaBeli,
    required super.satuan,
  });

  factory HargaModel.fromMap(Map<String, dynamic> map) {
    return HargaModel(
      idHarga: map['id_harga'] as int,
      hargaJual: (map['harga_jual'] as num).toDouble(),
      hargaBeli: (map['harga_beli'] as num).toDouble(),
      satuan: map['satuan'] as String,
    );
  }

  factory HargaModel.fromEntity(HargaEntity entity) {
    return HargaModel(
      idHarga: entity.idHarga,
      hargaJual: entity.hargaJual,
      hargaBeli: entity.hargaBeli,
      satuan: entity.satuan,
    );
  }
  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId) 'id_harga': idHarga,
      'harga_jual': hargaJual,
      'harga_beli': hargaBeli,
      'satuan': satuan,
    };
  }
}
