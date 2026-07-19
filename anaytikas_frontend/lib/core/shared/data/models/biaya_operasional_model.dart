import '../../domain/entitties/biaya_operasional_entity.dart';
import '../../extensions/datetime_extension.dart';
import 'package:intl/intl.dart';

class BiayaOperasionalModel extends BiayaOperasionalEntity {
  BiayaOperasionalModel({
    required super.idBiaya,
    required super.nama,
    required super.tanggal,
    required super.harga,
    required super.waktu,
  });

  factory BiayaOperasionalModel.fromMap(Map<String, dynamic> map) {
    return BiayaOperasionalModel(
      idBiaya: map["id_biaya"] as int,
      nama: map["nama"] as String,
      tanggal: DateTime.parse(map['tanggal'] as String),
      waktu: DateFormat('HH:mm:ss').parse(map['waktu'] as String),
      harga: (map["harga"] as num).toDouble(),
    );
  }

  factory BiayaOperasionalModel.fromEntity(BiayaOperasionalEntity entity) {
    return BiayaOperasionalModel(
      idBiaya: entity.idBiaya,
      nama: entity.nama,
      tanggal: entity.tanggal,
      harga: entity.harga,
      waktu: entity.waktu,
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId) "id_biaya": idBiaya,
      "nama": nama,
      "tanggal": tanggal.toDBDate(),
      "waktu": waktu.toTime(),
      "harga": harga,
    };
  }
}
