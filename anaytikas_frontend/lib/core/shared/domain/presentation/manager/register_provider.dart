import 'package:anaytikas_frontend/core/shared/domain/usecases/register_usecase.dart';
import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUsecase registerUsecase;

  RegisterProvider({required this.registerUsecase});

  String? message;
  bool _isLoading = false;

  // String? get notaPenjualan => _message;
  bool get isLoading => _isLoading;

  Future<String> register(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final message = await registerUsecase.call(email);
      _isLoading = false;
      notifyListeners();
      return message;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow; // lempar error supaya bisa ditangkap try-catch di UI
    }
  }
}
