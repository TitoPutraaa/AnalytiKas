import 'package:anaytikas_frontend/core/shared/domain/entitties/harga_entity.dart';
import 'package:anaytikas_frontend/core/shared/domain/entitties/kategori_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/update_product.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class EditProductProvider with ChangeNotifier {
  final UpdateProduct updateProduct;

  EditProductProvider({required this.updateProduct});

  String message = "";
  Status status = Status.initial;

  Future<void> edit(
    int idProduct,
    KategoriEntity kategori,
    HargaEntity harga,
    String namaProduct,
    int jmlhStok,
    int pengingatStok,
    bool isGrosir,
    bool isActivate,
  ) async {
    status = Status.loading;
    notifyListeners();

    try {
      await updateProduct.call(
        idProduct,
        kategori,
        harga,
        namaProduct,
        jmlhStok,
        pengingatStok,
        isGrosir,
        isActivate,
      );
      status = Status.success;
      notifyListeners();
    } catch (e) {
      message = "gagal menyimpan edit product provider. err:${e.toString()}";
      status = Status.error;
      notifyListeners();
    }
  }
}
