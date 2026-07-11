import '../../domain/entities/penjualan_item_entity.dart';

class PenjualanItemModel extends PenjualanItemEntity {
  PenjualanItemModel({
    required super.namaProduct,
    required super.jumlah,
    required super.satuan,
    required super.totalHargaProduct,
  });

  factory PenjualanItemModel.fromMap(Map<String, dynamic> map) {
    return PenjualanItemModel(
      namaProduct: map['nama_product'],
      jumlah: map['jumlah'],
      satuan: map['satuan'],
      totalHargaProduct: map['total_harga_product'],
    );
  }
}
