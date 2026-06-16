import 'package:anaytikas_frontend/features/stok/domain/usecases/add_biaya_operasional.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class BiayaOperasionalProvider with ChangeNotifier {
  final AddBiayaOperasional addBiayaOperasional;
  BiayaOperasionalProvider({required this.addBiayaOperasional});

  List<String> namaBiaya = ["Listrik", "Air", "Sewa", "Karyawan"];
  String message = "";
  Status status = Status.initial;

  Future<void> addBiayaOps({
    required int idBiaya,
    required String nama,
    required DateTime tanggal,
    required double totalBiaya,
  }) async {
    status = Status.loading;
    notifyListeners();
    try {
      await addBiayaOperasional.call(idBiaya, nama, tanggal, totalBiaya);
      status = Status.success;
      notifyListeners();
    } catch (e) {
      message = "gagal menyimpan biaya operasional. err:${e.toString()}";
      notifyListeners();
    }
  }
}
