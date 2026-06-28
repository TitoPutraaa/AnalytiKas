import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class ProfileProvider with ChangeNotifier {
  final GetProfileUsecase getProfileUsecase;
  final LogoutUsecase logoutUsecase;

  ProfileProvider({
    required this.getProfileUsecase,
    required this.logoutUsecase,
  });

  ProfileEntity _profile = ProfileEntity(
    idToko: 1,
    namaToko: "sss",
    email: "",
    noTelp: "",
    password: "",
    alamat: "",
  );
  String _message = "";
  Status status = Status.initial;
  ProfileEntity get profile => _profile;
  String get message => _message;

  Future<void> getProfile() async {
    status = Status.loading;
    notifyListeners();
    try {
      status = Status.success;
      _profile = await getProfileUsecase.call();
      notifyListeners();
    } catch (e) {
      status = Status.error;
      _message = "gagal memuat profile, provider err: ${e.toString()}";
      notifyListeners();
    }
  }

  Future<void> logout() async {
    status = Status.loading;
    notifyListeners();
    try {
      status = Status.success;
      await logoutUsecase.call();
      notifyListeners();
    } catch (e) {
      status = Status.error;
      _message = "gagal logout profile, provider err: ${e.toString()}";
      notifyListeners();
    }
  }
}
