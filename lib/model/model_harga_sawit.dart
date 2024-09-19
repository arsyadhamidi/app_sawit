// To parse this JSON data, do
//
//     final modelHargaSawit = modelHargaSawitFromJson(jsonString);

import 'dart:convert';

ModelHargaSawit modelHargaSawitFromJson(String str) => ModelHargaSawit.fromJson(json.decode(str));

String modelHargaSawitToJson(ModelHargaSawit data) => json.encode(data.toJson());

class ModelHargaSawit {
  int? status;
  bool? success;
  String? message;
  Data? data;

  ModelHargaSawit({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory ModelHargaSawit.fromJson(Map<String, dynamic> json) => ModelHargaSawit(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  DateTime? tanggal;
  String? hargaTbs;
  String? hargaBerondolan;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.tanggal,
    this.hargaTbs,
    this.hargaBerondolan,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    hargaTbs: json["harga_tbs"],
    hargaBerondolan: json["harga_berondolan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
    "harga_tbs": hargaTbs,
    "harga_berondolan": hargaBerondolan,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
