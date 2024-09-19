// To parse this JSON data, do
//
//     final modelPinjaman = modelPinjamanFromJson(jsonString);

import 'dart:convert';

ModelPinjaman modelPinjamanFromJson(String str) => ModelPinjaman.fromJson(json.decode(str));

String modelPinjamanToJson(ModelPinjaman data) => json.encode(data.toJson());

class ModelPinjaman {
  int? status;
  bool? success;
  List<DataPinjaman>? data;

  ModelPinjaman({
    this.status,
    this.success,
    this.data,
  });

  factory ModelPinjaman.fromJson(Map<String, dynamic> json) => ModelPinjaman(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<DataPinjaman>.from(json["data"]!.map((x) => DataPinjaman.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPinjaman {
  int? id;
  int? usersId;
  String? nomorPeminjaman;
  DateTime? tglAwal;
  DateTime? tglAkhir;
  String? nominal;
  String? alasan;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users? users;

  DataPinjaman({
    this.id,
    this.usersId,
    this.nomorPeminjaman,
    this.tglAwal,
    this.tglAkhir,
    this.nominal,
    this.alasan,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  factory DataPinjaman.fromJson(Map<String, dynamic> json) => DataPinjaman(
    id: json["id"],
    usersId: json["users_id"],
    nomorPeminjaman: json["nomor_peminjaman"],
    tglAwal: json["tgl_awal"] == null ? null : DateTime.parse(json["tgl_awal"]),
    tglAkhir: json["tgl_akhir"] == null ? null : DateTime.parse(json["tgl_akhir"]),
    nominal: json["nominal"],
    alasan: json["alasan"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users_id": usersId,
    "nomor_peminjaman": nomorPeminjaman,
    "tgl_awal": "${tglAwal!.year.toString().padLeft(4, '0')}-${tglAwal!.month.toString().padLeft(2, '0')}-${tglAwal!.day.toString().padLeft(2, '0')}",
    "tgl_akhir": "${tglAkhir!.year.toString().padLeft(4, '0')}-${tglAkhir!.month.toString().padLeft(2, '0')}-${tglAkhir!.day.toString().padLeft(2, '0')}",
    "nominal": nominal,
    "alasan": alasan,
    "status": status,
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
