import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';

class PembelianModel extends Pembelian {
  PembelianModel({
    required super.idPembelian,
    required super.tanggal,
    required super.waktu,
    required super.totalHarga,
  });

  factory PembelianModel.fromMap(Map<String, dynamic> data) {
    return PembelianModel(
      idPembelian: data["id_pembelian"] as int,
      tanggal: DateTime.parse(data["tanggal"] as String),
      waktu: data["waktu"] as String,
      totalHarga: (data["total_harga"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_pembelian": idPembelian,
      "tanggal": tanggal,
      "waktu": waktu,
      "total_harga": totalHarga,
    };
  }
}
