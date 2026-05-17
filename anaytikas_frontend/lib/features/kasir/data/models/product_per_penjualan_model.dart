import 'package:anaytikas_frontend/features/kasir/domain/entities/product_per_penjualan_entity.dart';

class ProductPerPenjualanModel extends ProductPerPenjualanEntity {
  ProductPerPenjualanModel({
    required super.idPenjualan,
    required super.idProduct,
    required super.jumlah,
  });

  factory ProductPerPenjualanModel.fromMap(Map<String, dynamic> map) {
    return ProductPerPenjualanModel(
      idPenjualan: map['id-penjualan'] as int,
      idProduct: map['id-product'] as int,
      jumlah: map['jumlah'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id-penjualan': idProduct,
      'idProduct': idProduct,
      'jumlah': jumlah,
    };
  }
}
