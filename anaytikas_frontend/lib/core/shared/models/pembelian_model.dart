import '../entities/pembelian_entity.dart';

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
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalHarga: (map['total_harga'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_pembelian': idPembelian,
      'tanggal': tanggal,
      'waktu': waktu,
      'total_harga': totalHarga,
    };
  }
}
