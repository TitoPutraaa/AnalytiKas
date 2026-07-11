import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/forgot_pass_otp_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/forgot_pass_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/register_account_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/reset_pass_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/validate_account_usecase.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class AuthProvider with ChangeNotifier {
  final LogoutUsecase logoutUsecase;
  final LoginUsecase loginUsecase;
  final RegisterAccountUsecase registerAccountUsecase;
  final ValidateAccountUsecase validateAccountUsecase;
  final ForgotPassUsecase forgotPassUsecase;
  final ForgotPassOtpUsecase forgotPassOtpUsecase;
  final ResetPassUsecase resetPassUsecase;

  AuthProvider({
    required this.logoutUsecase,
    required this.loginUsecase,
    required this.validateAccountUsecase,
    required this.registerAccountUsecase,
    required this.forgotPassUsecase,
    required this.forgotPassOtpUsecase,
    required this.resetPassUsecase,
  });

  TokoEntity? _dataToko;
  String _message = "";
  String _emailUsr = '';
  Status status = Status.initial;
  String get message => _message;

  Future<void> login(String email, String pass) async {
    status = Status.loading;
    notifyListeners();
    try {
      final result = await loginUsecase.call(email, pass);
      if (result.success) {
        status = Status.success;
        _message = result.message;
        print(_message);
        notifyListeners();
      } else {
        status = Status.error;
        _message = result.message;
        print(_message);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      print(_message);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    status = Status.loading;
    notifyListeners();
    try {
      status = Status.success;
      final result = await logoutUsecase.call();
      _message = result.message;
      print(result.message);
      notifyListeners();
    } catch (e) {
      status = Status.error;
      _message = "gagal logout profile, provider err: ${e.toString()}";
      notifyListeners();
    }
  }

  Future<void> createAccount(
    String email,
    String namaToko,
    String noTelp,
    String alamat,
    String pass,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      final result = await registerAccountUsecase.call(email);
      _dataToko = TokoEntity(
        idToko: 1,
        namaToko: namaToko,
        email: email,
        noTelp: noTelp,
        password: pass,
        alamat: alamat,
      );
      _message = result.message;
      status = Status.success;
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> resedOtp() async {
    try {
      final email = _dataToko!.email;
      final result = await registerAccountUsecase.call(email);
      _message = result.message;
    } catch (e) {
      _message = e.toString();
      print(e);
    }
  }

  Future<void> resedOtpPass() async {
    try {
      final result = await registerAccountUsecase.call(_emailUsr);
      _message = result.message;
    } catch (e) {
      _message = e.toString();
      print(e);
    }
  }

  Future<void> validateAccount(int otp) async {
    status = Status.loading;
    notifyListeners();
    try {
      final result = await validateAccountUsecase.call(_dataToko!, otp);
      _message = result.message;
      status = Status.success;
      _dataToko = null;
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> validateEmail(String email) async {
    status = Status.loading;
    notifyListeners();
    try {
      final result = await forgotPassUsecase.call(email);
      _message = result.message;
      print(_message);
      _emailUsr = email;
      if (result.success) {
        status = Status.success;
      } else {
        status = Status.error;
      }
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> passOtp(int otp) async {
    status = Status.loading;
    notifyListeners();

    try {
      final result = await forgotPassOtpUsecase.call(_emailUsr, otp);
      _message = result.message;
      print(_message);
      if (result.success) {
        status = Status.success;
      } else {
        status = Status.error;
      }
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> resetPass(String pass) async {
    status = Status.loading;
    notifyListeners();

    try {
      final result = await resetPassUsecase.call(_emailUsr, pass);
      _message = result.message;
      if (result.success) {
        status = Status.success;
        _emailUsr = '';
      } else {
        status = Status.error;
      }
    } catch (e) {
      status = Status.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  void resetMessage() {
    _message = '';
    notifyListeners();
  }
}
