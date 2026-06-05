import 'package:anaytikas_frontend/features/riwayat/domain/entities/pembelian_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/product_per_pembelian_entity.dart';

class PembelianModel extends PembelianEntity {
  PembelianModel({
    required super.idPembelian,
    required super.tanggal,
    required super.waktu,
    required super.totalItem,
    required super.totalHarga,
  });

  factory PembelianModel.fromMap(
    Map<String, dynamic> map, {
    List<ProductPerPembelianEntity> items = const [],
  }) {
    return PembelianModel(
      idPembelian: map['id_pembelian'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_pembelian': idPembelian,
      'tanggal': tanggal,
      'waktu': waktu,
      'total_item': totalItem,
      'total_harga': totalHarga,
    };
  }
}
