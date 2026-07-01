import 'package:anaytikas_frontend/core/shared/entities/biaya_opr_entity.dart';

class BiayaOprModel extends BiayaOprEntity {
  BiayaOprModel({
    required super.idBiaya,
    required super.nama,
    required super.tanggal,
    required super.totalBiaya,
    required super.waktu,
  });

  factory BiayaOprModel.fromMap(Map<String, dynamic> data) {
    return BiayaOprModel(
      idBiaya: data["id_biaya"] as int,
      nama: data["nama"] as String,
      tanggal: DateTime.parse(data["tanggal"] as String),
      waktu: DateTime.parse(data["waktu"] as String),
      totalBiaya: (data["total_biaya"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_biaya": idBiaya,
      "nama": nama,
      "tanggal": tanggal.toString(),
      "waktu": waktu.toString(),
      "total_biaya": totalBiaya,
    };
  }
}
