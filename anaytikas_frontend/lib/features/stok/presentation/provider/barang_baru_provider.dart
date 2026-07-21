import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
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
    required Pembelian pembelian,
    required ProductEntity product,
    required int jumlah,
  }) async {
    _status = Status.loading;
    notifyListeners();
    try {
      _isLoading = false;
      await addBarangBaru.call(pembelian, product, jumlah);
      _status = Status.success;
      notifyListeners();
    } on AddBarangBaruException catch (e) {
      _status = Status.error;
      _message = e.message;
      notifyListeners();
    } catch (e) {
      _message = "gagal menambahkan barang baru provider. err${e.toString()}";
      _status = Status.error;
      notifyListeners();
    }
  }
}
