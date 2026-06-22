import 'package:anaytikas_frontend/features/riwayat/data/models/transaksi_item_model.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_pembelian_entity.dart';

class RiwayatPembelianModel extends RiwayatPembelianEntity {
  RiwayatPembelianModel({
    required super.idPembelian,
    required super.tanggal,
    required super.waktu,
    required super.totalItem,
    required super.totalHarga,
    required super.productsTerjual,
  });

  factory RiwayatPembelianModel.fromMap(Map<String, dynamic> map) {
    return RiwayatPembelianModel(
      idPembelian: map['id_pembelian'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
      productsTerjual: (map['products_terjual'] as List<dynamic>)
          .map((e) => TransaksiItemModel.fromMap(e))
          .toList(),
    );
  }
}
