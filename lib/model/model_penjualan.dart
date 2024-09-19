// To parse this JSON data, do
//
//     final modelPenjualan = modelPenjualanFromJson(jsonString);

import 'dart:convert';

ModelPenjualan modelPenjualanFromJson(String str) => ModelPenjualan.fromJson(json.decode(str));

String modelPenjualanToJson(ModelPenjualan data) => json.encode(data.toJson());

class ModelPenjualan {
  int? status;
  bool? success;
  List<DataPenjualan>? data;

  ModelPenjualan({
    this.status,
    this.success,
    this.data,
  });

  factory ModelPenjualan.fromJson(Map<String, dynamic> json) => ModelPenjualan(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<DataPenjualan>.from(json["data"]!.map((x) => DataPenjualan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPenjualan {
  int? id;
  int? supirId;
  int? pemuatId;
  int? petaniId;
  DateTime? tanggal;
  String? quantityTbs;
  String? totalTbs;
  String? quantityBerondolan;
  String? totalBerondolan;
  String? totalPembelian;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pemuat? supir;
  Pemuat? pemuat;

  DataPenjualan({
    this.id,
    this.supirId,
    this.pemuatId,
    this.petaniId,
    this.tanggal,
    this.quantityTbs,
    this.totalTbs,
    this.quantityBerondolan,
    this.totalBerondolan,
    this.totalPembelian,
    this.createdAt,
    this.updatedAt,
    this.supir,
    this.pemuat,
  });

  factory DataPenjualan.fromJson(Map<String, dynamic> json) => DataPenjualan(
    id: json["id"],
    supirId: json["supir_id"],
    pemuatId: json["pemuat_id"],
    petaniId: json["petani_id"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    quantityTbs: json["quantity_tbs"],
    totalTbs: json["total_tbs"],
    quantityBerondolan: json["quantity_berondolan"],
    totalBerondolan: json["total_berondolan"],
    totalPembelian: json["total_pembelian"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    supir: json["supir"] == null ? null : Pemuat.fromJson(json["supir"]),
    pemuat: json["pemuat"] == null ? null : Pemuat.fromJson(json["pemuat"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supir_id": supirId,
    "pemuat_id": pemuatId,
    "petani_id": petaniId,
    "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
    "quantity_tbs": quantityTbs,
    "total_tbs": totalTbs,
    "quantity_berondolan": quantityBerondolan,
    "total_berondolan": totalBerondolan,
    "total_pembelian": totalPembelian,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "supir": supir?.toJson(),
    "pemuat": pemuat?.toJson(),
  };
}

class Pemuat {
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

  Pemuat({
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

  factory Pemuat.fromJson(Map<String, dynamic> json) => Pemuat(
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
