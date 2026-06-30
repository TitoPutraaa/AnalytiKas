import '../entities/product_per_penjualan_entity.dart';

class ProductPerPenjualanModel extends ProductPerPenjualanEntity {
  ProductPerPenjualanModel({
    required super.idPenjualan,
    required super.idProduct,
    required super.jumlah,
  });

  factory ProductPerPenjualanModel.fromMap(Map<String, dynamic> map) {
    return ProductPerPenjualanModel(
      idPenjualan: map['id_penjualan'] as int,
      idProduct: map['id_product'] as int,
      jumlah: map['jumlah'] as int,
    );
  }

  factory ProductPerPenjualanModel.fromEntity(
    ProductPerPenjualanEntity entity,
  ) {
    return ProductPerPenjualanModel(
      idPenjualan: entity.idPenjualan,
      idProduct: entity.idProduct,
      jumlah: entity.jumlah,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_penjualan': idProduct,
      'id_product': idProduct,
      'jumlah': jumlah,
    };
  }
}
