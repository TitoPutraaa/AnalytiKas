import 'package:anaytikas_frontend/core/shared/extensions/datetime_extension.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/biaya_operasional.dart';

class BiayaOperasionalModel extends BiayaOperasional {
  BiayaOperasionalModel({
    required super.idBiaya,
    required super.nama,
    required super.tanggal,
    required super.totalBiaya,
    required super.waktu,
  });

  factory BiayaOperasionalModel.fromMap(Map<String, dynamic> data) {
    return BiayaOperasionalModel(
      idBiaya: data["id_biaya"] as int,
      nama: data["nama"] as String,
      tanggal: DateTime.parse(data["tanggal"] as String),
      waktu: DateTime.parse(data["waktu"] as String),
      totalBiaya: (data["total_biaya"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    final map = {
      "id_biaya": idBiaya,
      "nama": nama,
      "tanggal": tanggal.toDBDate(),
      "waktu": waktu.toTime(),
      "total_biaya": totalBiaya,
    };
    if (!includeId) map.remove("id_biaya");
    return map;
  }
}
