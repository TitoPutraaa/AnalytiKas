import 'package:anaytikas_frontend/core/shared/entities/session_user_entity.dart';

class SessionUserModel extends SessionUserEntity {
  SessionUserModel({required super.email, required super.token});

  factory SessionUserModel.fromJson(Map<String, dynamic> json) {
    return SessionUserModel(email: json['email'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'token': token};
  }
}
