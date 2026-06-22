import 'package:anaytikas_frontend/features/riwayat/domain/entities/transaksi_item_entity.dart';

class TransaksiItemModel extends TransaksiItemEntity {
  TransaksiItemModel({
    required super.namaProduct,
    required super.jumlah,
    required super.satuan,
    required super.totalHargaProduct,
  });

  factory TransaksiItemModel.fromMap(Map<String, dynamic> map) {
    return TransaksiItemModel(
      namaProduct: map['namaProduct'],
      jumlah: map['jumlah'],
      satuan: map['satuan'],
      totalHargaProduct: map['totalHargaProduct'],
    );
  }
}
