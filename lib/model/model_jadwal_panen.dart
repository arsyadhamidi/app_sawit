// To parse this JSON data, do
//
//     final modelJadwalPanen = modelJadwalPanenFromJson(jsonString);

import 'dart:convert';

ModelJadwalPanen modelJadwalPanenFromJson(String str) => ModelJadwalPanen.fromJson(json.decode(str));

String modelJadwalPanenToJson(ModelJadwalPanen data) => json.encode(data.toJson());

class ModelJadwalPanen {
  int? status;
  bool? success;
  List<DataJadwal>? data;

  ModelJadwalPanen({
    this.status,
    this.success,
    this.data,
  });

  factory ModelJadwalPanen.fromJson(Map<String, dynamic> json) => ModelJadwalPanen(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<DataJadwal>.from(json["data"]!.map((x) => DataJadwal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataJadwal {
  int? id;
  int? petaniId;
  String? waktuPanen;
  String? luasKebun;
  String? lokasiKebun;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  Petani? petani;

  DataJadwal({
    this.id,
    this.petaniId,
    this.waktuPanen,
    this.luasKebun,
    this.lokasiKebun,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.petani,
  });

  factory DataJadwal.fromJson(Map<String, dynamic> json) => DataJadwal(
    id: json["id"],
    petaniId: json["petani_id"],
    waktuPanen: json["waktu_panen"],
    luasKebun: json["luas_kebun"],
    lokasiKebun: json["lokasi_kebun"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    petani: json["petani"] == null ? null : Petani.fromJson(json["petani"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "petani_id": petaniId,
    "waktu_panen": waktuPanen,
    "luas_kebun": luasKebun,
    "lokasi_kebun": lokasiKebun,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "petani": petani?.toJson(),
  };
}

class Petani {
  int? id;
  int? usersId;
  String? nama;
  String? telp;
  String? alamatDomisili;
  String? alamatKebun;
  DateTime? createdAt;
  DateTime? updatedAt;

  Petani({
    this.id,
    this.usersId,
    this.nama,
    this.telp,
    this.alamatDomisili,
    this.alamatKebun,
    this.createdAt,
    this.updatedAt,
  });

  factory Petani.fromJson(Map<String, dynamic> json) => Petani(
    id: json["id"],
    usersId: json["users_id"],
    nama: json["nama"],
    telp: json["telp"],
    alamatDomisili: json["alamat_domisili"],
    alamatKebun: json["alamat_kebun"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  };
}
