import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_barang_baru.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class BarangBaruProvider with ChangeNotifier {
  final AddBarangBaru addBarangBaru;

  BarangBaruProvider({required this.addBarangBaru});

  String _message = "";
  Status _status = Status.initial;
  bool _isLoading = true;

  String get message => _message;
  Status get status => _status;
  bool get isLoading => _isLoading;

  Future<void> barangBaru({
    required String idProduct,
    required Kategori kategori,
    required HargaProduct harga,
    required String namaProduct,
    required int jmlhStok,
    required int stokWarning,
    required bool isGrosir,
    required bool isActivate,
  }) async {
    _status = Status.loading;
    notifyListeners();
    try {
      _isLoading = false;
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
      _status = Status.success;
    } catch (e) {
      _message = "gagal menambahkan barang baru provider. err${e.toString()}";
      _status = Status.error;
      notifyListeners();
    }
  }
}
