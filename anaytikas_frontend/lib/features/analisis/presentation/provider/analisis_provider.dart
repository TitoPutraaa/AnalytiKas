import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/usecases/get_analisis.dart';
import 'package:anaytikas_frontend/features/analisis/domain/usecases/sync_analisis.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error, offline }

class AnalisisProvider extends ChangeNotifier {
  final GetAnalisis getAnalisis;
  final SyncAnalisis syncAnalisis;

  AnalisisProvider({required this.getAnalisis, required this.syncAnalisis});

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

  Future<void> loadAnalisis() async {
    status = Status.loading;
    message = '';
    notifyListeners();
    try {
      analisisEntitiy = await getAnalisis.call();
      status = Status.success;
      notifyListeners();
    } catch (e) {
      final error = e.toString().replaceFirst("Exception: ", "");
      if (error == 'Tidak ada koneksi internet') {
        message = 'Waduh Internetmu hilang. Coba lagi ya :)';
      } else if (error == '500') {
        message = 'Trafik server penuh ni. Coba lagi ya :)';
      } else if (error == 'sesi habis') {
        message =
            'Sesi Habis. Sistem otomatis akan memuat halaman login. Harap tunggu...';
      } else {
        message = 'Sistem analisis sedang bermasalah. Coba lagi...';
      }
      status = Status.error;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateAnalisis() async {
    status = Status.loading;
    message = '';
    notifyListeners();
    try {
      analisisEntitiy = await syncAnalisis.call();
      status = Status.success;
      notifyListeners();
    } catch (e) {
      final error = e.toString().replaceFirst("Exception: ", "");
      if (error == 'Tidak ada koneksi internet') {
        message = 'Waduh Internetmu hilang. Coba lagi ya :)';
      } else if (error == '500') {
        message = 'Trafik server penuh ni. Coba lagi ya :)';
      } else if (error == 'sesi habis') {
        message =
            'Sesi Habis. Sistem otomatis akan memuat halaman login. Harap tunggu...';
      } else {
        message = 'Sistem analisis sedang bermasalah. Coba lagi...';
      }
      status = Status.error;
      notifyListeners();
      rethrow;
    }
  }
}
