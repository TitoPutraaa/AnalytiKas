import '../entities/product_per_pembelian_entity.dart';

class ProductPerPembelianModel extends ProductPerPembelianEntity {
  ProductPerPembelianModel({
    required super.idPembelian,
    required super.idProduct,
    required super.jumlah,
  });

  factory ProductPerPembelianModel.fromMap(Map<String, dynamic> map) {
    return ProductPerPembelianModel(
      idPembelian: map['id_pembelian'] as int,
      idProduct: map['id_product'] as int,
      jumlah: map['jumlah'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_pembelian': idPembelian,
      'id_product': idProduct,
      'jumlah': jumlah,
    };
  }
}
