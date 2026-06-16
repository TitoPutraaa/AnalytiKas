import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_barang_baru.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class BarangBaruProvider with ChangeNotifier {
  final AddBarangBaru addBarangBaru;

  BarangBaruProvider({required this.addBarangBaru});

  String message = "";
  Status status = Status.initial;

  Future<void> barangBaru(
    String idProduct,
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
      await addBarangBaru.call(
        idProduct,
        kategori,
        harga,
        namaProduct,
        jmlhStok,
        stokWarning,
        isGrosir,
        isActivate,
      );
    } catch (e) {
      message = "gagal menambahkan barang baru provider. err${e.toString()}";
      notifyListeners();
    }
  }
}
