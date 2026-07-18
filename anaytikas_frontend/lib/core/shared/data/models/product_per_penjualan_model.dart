import 'harga_model.dart';
import 'kategori_model.dart';
import 'penjualan_model.dart';
import 'product_model.dart';

import '../../domain/entitties/product_per_penjualan_entity.dart';

class ProductPerPenjualanModel extends ProductPerPenjualanEntity {
  ProductPerPenjualanModel({
    required super.penjualan,
    required super.product,
    required super.hargaSatuan,
    required super.jumlah,
  });

  factory ProductPerPenjualanModel.fromMap(Map<String, dynamic> map) {
    return ProductPerPenjualanModel(
      penjualan: PenjualanModel.fromMap({
        'id_penjualan': map['id_penjualan'],
        'tanggal': map['tanggal'],
        'waktu': map['waktu'],
        'total_item': map['total_item'],
        'total_harga': map['total_harga'],
      }),

      product: ProductModel.fromMap(map),

      hargaSatuan: (map['harga_satuan'] as num).toDouble(),
      jumlah: map['jumlah'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_penjualan': penjualan.idPenjualan,
      'id_product': product.idProduct,
      'harga_satuan': product.harga.hargaJual,
      'jumlah': jumlah,
    };
  }
}
