// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  int? status;
  bool? success;
  String? message;
  User? user;

  ModelUser({
    this.status,
    this.success,
    this.message,
    this.user,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "user": user?.toJson(),
  };

  @override
  String toString() {
    return 'ModelUser{status: $status, success: $success, message: $message, user: $user}';
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? password;
  int? levelId;
  String? telp;
  dynamic fotoProfile;
  dynamic pekerjaId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.username,
    this.password,
    this.levelId,
    this.telp,
    this.fotoProfile,
    this.pekerjaId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    password: json["password"],
    levelId: json["level_id"],
    telp: json["telp"],
    fotoProfile: json["foto_profile"],
    pekerjaId: json["pekerja_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "password": password,
    "level_id": levelId,
    "telp": telp,
    "foto_profile": fotoProfile,
    "pekerja_id": pekerjaId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, telp: $telp, levelId: $levelId}';
  }
}
