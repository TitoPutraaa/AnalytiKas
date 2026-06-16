import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_stok.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class TambahStokProvider with ChangeNotifier {
  final AddStok addStok;

  TambahStokProvider({required this.addStok});

  String message = "";
  Status status = Status.initial;

  Future<void> add(Pembelian pembelian, ProductEntity product) async {
    status = Status.loading;
    notifyListeners();

    try {
      await addStok.call(pembelian, product);
      notifyListeners();
    } catch (e) {
      message = "gagal menyimpan stok baru. err:${e.toString()}";
      notifyListeners();
    }
  }
}
