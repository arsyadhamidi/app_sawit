// To parse this JSON data, do
//
//     final modelSupir = modelSupirFromJson(jsonString);

import 'dart:convert';

ModelSupir modelSupirFromJson(String str) => ModelSupir.fromJson(json.decode(str));

String modelSupirToJson(ModelSupir data) => json.encode(data.toJson());

class ModelSupir {
  int? status;
  bool? success;
  List<DataSupir>? data;

  ModelSupir({
    this.status,
    this.success,
    this.data,
  });

  factory ModelSupir.fromJson(Map<String, dynamic> json) => ModelSupir(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<DataSupir>.from(json["data"]!.map((x) => DataSupir.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataSupir {
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

  DataSupir({
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

  factory DataSupir.fromJson(Map<String, dynamic> json) => DataSupir(
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
