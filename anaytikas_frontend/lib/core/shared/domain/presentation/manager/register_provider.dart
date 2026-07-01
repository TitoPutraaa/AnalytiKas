import 'package:anaytikas_frontend/core/shared/domain/usecases/register_usecase.dart';
import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';
import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUsecase registerUsecase;

  RegisterProvider({required this.registerUsecase});

  String? message;

  Future<String> register(String email) async {
    try {
      final message = await registerUsecase.call(email);
      notifyListeners();
      return message;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<String> registerOtp(String email, int otp) async {
    try {
      final message = await registerUsecase.call2(email, otp);
      notifyListeners();
      return message;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<String> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
    String namaToko,
  ) async {
    try {
      final message = await registerUsecase.callNewAccount(
        email,
        pass,
        noTelp,
        alamat,
        namaToko,
      );
      notifyListeners();
      return message;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<String> login(String email, String pass) async {
    try {
      final message = await registerUsecase.callLogin(email, pass);
      notifyListeners();
      return message;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<String> logout() async {
    try {
      final message = await registerUsecase.callLogout();
      notifyListeners();
      return message;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<TokoEntity> getToko() async {
    try {
      final dataToko = await registerUsecase.getToko();
      notifyListeners();
      print(dataToko);
      return dataToko;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }

  Future<String> syncAllData() async {
    try {
      final data = await registerUsecase.syncAllData();
      notifyListeners();
      print(data);
      return data;
    } catch (e) {
      print(e);
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }
}
