// To parse this JSON data, do
//
//     final modelPemuat = modelPemuatFromJson(jsonString);

import 'dart:convert';

ModelPemuat modelPemuatFromJson(String str) => ModelPemuat.fromJson(json.decode(str));

String modelPemuatToJson(ModelPemuat data) => json.encode(data.toJson());

class ModelPemuat {
  int? status;
  bool? success;
  List<DataPemuat>? data;

  ModelPemuat({
    this.status,
    this.success,
    this.data,
  });

  factory ModelPemuat.fromJson(Map<String, dynamic> json) => ModelPemuat(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<DataPemuat>.from(json["data"]!.map((x) => DataPemuat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPemuat {
  int? id;
  int? levelId;
  String? nik;
  String? nama;
  String? telp;
  String? sim;
  String? alamat;
  String? fotoPekerja;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataPemuat({
    this.id,
    this.levelId,
    this.nik,
    this.nama,
    this.telp,
    this.sim,
    this.alamat,
    this.fotoPekerja,
    this.createdAt,
    this.updatedAt,
  });

  factory DataPemuat.fromJson(Map<String, dynamic> json) => DataPemuat(
    id: json["id"],
    levelId: json["level_id"],
    nik: json["nik"],
    nama: json["nama"],
    telp: json["telp"],
    sim: json["sim"],
    alamat: json["alamat"],
    fotoPekerja: json["foto_pekerja"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level_id": levelId,
    "nik": nik,
    "nama": nama,
    "telp": telp,
    "sim": sim,
    "alamat": alamat,
    "foto_pekerja": fotoPekerja,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
