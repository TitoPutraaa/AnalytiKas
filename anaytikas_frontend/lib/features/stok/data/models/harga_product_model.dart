import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';

class HargaProductModel extends HargaProduct {
  HargaProductModel({
    required super.idHarga,
    required super.hargaJual,
    required super.hargaBeli,
    required super.satuan,
  });

  factory HargaProductModel.fromMap(Map<String, dynamic> data) {
    return HargaProductModel(
      idHarga: data["id_harga"] as int,
      hargaJual: (data["harga_jual"] as num).toDouble(),
      hargaBeli: (data["harga_beli"] as num).toDouble(),
      satuan: data["satuan"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_harga": idHarga,
      "harga_jual": hargaJual,
      "harga_beli": hargaBeli,
      "satuan": satuan,
      "jmlh_satuan": 1,
    };
  }
}
