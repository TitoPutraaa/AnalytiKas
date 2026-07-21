import 'package:anaytikas_frontend/features/stok/domain/usecases/add_biaya_operasional.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class BiayaOperasionalProvider with ChangeNotifier {
  final AddBiayaOperasional addBiayaOperasional;
  BiayaOperasionalProvider({required this.addBiayaOperasional});

  List<String> namaBiaya = ["Listrik", "Air", "Sewa", "Karyawan"];
  String message = "";
  Status _status = Status.initial;
  bool succes = false;
  Status get status => _status;

  Future<void> addBiayaOps({
    required int idBiaya,
    required String nama,
    required DateTime tanggal,
    required DateTime waktu,
    required double totalBiaya,
  }) async {
    _status = Status.loading;
    notifyListeners();
    try {
      await addBiayaOperasional.call(idBiaya, nama, tanggal, waktu, totalBiaya);
      _status = Status.success;
      succes = true;
      notifyListeners();
    } on BiayaOperasionalException catch (e) {
      _status = Status.error;
      message = e.message;
      succes = false;
      notifyListeners();
    } catch (e) {
      message = "gagal menyimpan biaya operasional. err:${e.toString()}";
      _status = Status.error;
      succes = false;
      notifyListeners();
    }
  }
}
