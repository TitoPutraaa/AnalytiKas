import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
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
    Kategori kategori,
    HargaProduct harga,
    String namaProduct,
    int jmlhStok,
    int stokWarning,
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
        stokWarning,
        isGrosir,
        isActivate,
      );
      status = Status.success;
      notifyListeners();
    } on UpdateProductException catch (e) {
      message = e.message;
      status = Status.error;
      notifyListeners();
    } catch (e) {
      message = "gagal menyimpan edit product provider. err:${e.toString()}";
      status = Status.error;
      notifyListeners();
    }
  }
}
