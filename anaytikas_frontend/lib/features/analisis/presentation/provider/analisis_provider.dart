import 'package:anaytikas_frontend/core/config/network/connectivity_helper.dart';
import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/usecases/get_analisis.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error, offline }

class AnalisisProvider extends ChangeNotifier {
  final GetAnalisis getAnalisis;

  AnalisisProvider({required this.getAnalisis});

  Status status = Status.initial;
  AnalisisEntitiy analisisEntitiy = AnalisisEntitiy(
    brutto: 0,
    netto: 0,
    margin: 0,
    presentase: 0,
    tahun: 0,
    totalBiayaOperasional: 0,
    totalPembelian: 0,
    totalPenjualan: 0,
    bulan: "",
  );
  String message = "";
  var connection = ConnectivityHelper().isOnline();

  Future<void> loadAnalisis({
    required String email,
    required String token,
  }) async {
    status = Status.loading;
    notifyListeners();
    try {
      analisisEntitiy = await getAnalisis.call(email, token);
      status = Status.success;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = 'gagal memuat data analisis. err: ${e.toString()}';
      notifyListeners();
    }
    if (!await connection) {
      status = Status.offline;
      message =
          "Pastikan anda terhubung dengan internet untuk mengakses halaman ini";
      notifyListeners();
    }
  }
}
