import 'package:anaytikas_frontend/features/auth/domain/entities/profile_entity.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, error }

class ProfileProvider with ChangeNotifier {
  final GetProfileUsecase getProfileUsecase;
  final LogoutUsecase logoutUsecase;
  final EditProfileUsecase editProfileUsecase;

  ProfileProvider({
    required this.getProfileUsecase,
    required this.logoutUsecase,
    required this.editProfileUsecase,
  });

  ProfileEntity _profile = ProfileEntity(
    idToko: 1,
    namaToko: "",
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

  Future<void> editProfile(
    String namaToko,
    String noTelp,
    String alamat,
    int idToko,
  ) async {
    status = Status.loading;
    notifyListeners();

    try {
      status = Status.success;
      await editProfileUsecase.call(namaToko, noTelp, alamat, idToko);
      notifyListeners();
    } catch (e) {
      status = Status.error;
      _message = "gagal edit profile, provider err: ${e.toString()}";
      notifyListeners();
    }
  }
}
