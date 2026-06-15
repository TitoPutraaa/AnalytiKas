import 'package:anaytikas_frontend/features/stok/domain/entities/biaya_operasional.dart';

class BiayaOperasionalModel extends BiayaOperasional {
  BiayaOperasionalModel({
    required super.idBiaya,
    required super.nama,
    required super.tanggal,
    required super.totalBiaya,
  });

  factory BiayaOperasionalModel.fromMap(Map<String, dynamic> data) {
    return BiayaOperasionalModel(
      idBiaya: data["id_biaya"] as int,
      nama: data["nama"] as String,
      tanggal: DateTime.parse(data["tanggal"] as String),
      totalBiaya: (data["total_biaya"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_biaya": idBiaya,
      "nama": nama,
      "tanggal": tanggal,
      "total_biaya": totalBiaya,
    };
  }
}
