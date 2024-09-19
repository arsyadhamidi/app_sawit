// To parse this JSON data, do
//
//     final modelDataPetani = modelDataPetaniFromJson(jsonString);

import 'dart:convert';

ModelDataPetani modelDataPetaniFromJson(String str) => ModelDataPetani.fromJson(json.decode(str));

String modelDataPetaniToJson(ModelDataPetani data) => json.encode(data.toJson());

class ModelDataPetani {
  int? status;
  bool? success;
  Data? data;

  ModelDataPetani({
    this.status,
    this.success,
    this.data,
  });

  factory ModelDataPetani.fromJson(Map<String, dynamic> json) => ModelDataPetani(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? usersId;
  String? nama;
  String? telp;
  String? alamatDomisili;
  String? alamatKebun;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users? users;

  Data({
    this.id,
    this.usersId,
    this.nama,
    this.telp,
    this.alamatDomisili,
    this.alamatKebun,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    usersId: json["users_id"],
    nama: json["nama"],
    telp: json["telp"],
    alamatDomisili: json["alamat_domisili"],
    alamatKebun: json["alamat_kebun"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users_id": usersId,
    "nama": nama,
    "telp": telp,
    "alamat_domisili": alamatDomisili,
    "alamat_kebun": alamatKebun,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "users": users?.toJson(),
  };
}

class Users {
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

  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
}
