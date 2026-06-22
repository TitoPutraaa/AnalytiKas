import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_biaya_operasi_entity.dart';

class RiwayatBiayaOperasiModel extends RiwayatBiayaOperasiEntity {
  RiwayatBiayaOperasiModel({
    required super.idBiaya,
    required super.tanggal,
    required super.waktu,
    required super.namaBiaya,
    required super.totalBiaya,
  });

  factory RiwayatBiayaOperasiModel.fromMap(Map<String, dynamic> map) {
    return RiwayatBiayaOperasiModel(
      idBiaya: map['id_biaya'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      namaBiaya: map['nama_biaya'] as String,
      totalBiaya: (map['total_biaya'] as num).toDouble(),
    );
  }
}
