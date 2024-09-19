
import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/model/model_data_petani.dart';
import 'package:app_sawit/model/model_harga_sawit.dart';
import 'package:app_sawit/model/model_jadwal_panen.dart';
import 'package:app_sawit/model/model_pemuat.dart';
import 'package:app_sawit/model/model_penjualan.dart';
import 'package:app_sawit/model/model_pinjaman.dart';
import 'package:app_sawit/model/model_supir.dart';
import 'package:http/http.dart' as http;

class NetworkProvider{

  Future<ModelHargaSawit?> getDataHargaSawit() async {
    final response = await http.get(Uri.parse(ApiConfig.url + 'harga-sawit'));

    if (response.statusCode == 200) {
      return modelHargaSawitFromJson(response.body);
    } else {
      // Handle the error response
      print('Failed to load data');
      return null;
    }
  }

  Future<ModelDataPetani?> getDataPetani() async {
    final response = await http.get(Uri.parse(ApiConfig.url + 'data-petani/${dataGlobal.user?.user?.id}'));

    if (response.statusCode == 200) {
      return modelDataPetaniFromJson(response.body);
    } else {
      // Handle the error response
      print('Failed to load data');
      return null;
    }
  }

  Future<ModelJadwalPanen?> getJadwalPanen() async {
    final response = await http.get(Uri.parse(ApiConfig.url + 'jadwal-panen/${dataGlobal.user?.user?.id}'));

    if (response.statusCode == 200) {
      return modelJadwalPanenFromJson(response.body);
    } else {
      // Handle the error response
      print('Failed to load data');
      return null;
    }
  }

  Future<ModelPinjaman?> getDataPinjaman() async {
    final response = await http.get(Uri.parse(ApiConfig.url + 'peminjaman/${dataGlobal.user?.user?.id}'));

    if (response.statusCode == 200) {
      return modelPinjamanFromJson(response.body);
    } else {
      // Handle the error response
      print('Failed to load data');
      return null;
    }
  }

  Future<ModelPenjualan?> getDataPenjualan() async {
    final response = await http.get(Uri.parse(ApiConfig.url + 'penjualan/${dataGlobal.user?.user?.id}'));

    if (response.statusCode == 200) {
      return modelPenjualanFromJson(response.body);
    } else {
      // Handle the error response
      print('Failed to load data');
      return null;
    }
  }

  Future<List<DataSupir>?> getDataSupir() async {
    try {
      final response =
      await http.get(Uri.parse(ApiConfig.url + "get-supir"));

      ModelSupir getSupir = await modelSupirFromJson(response.body);
      return getSupir.data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<DataPemuat>?> getDataPemuat() async {
    try {
      final response =
      await http.get(Uri.parse(ApiConfig.url + "get-pemuat"));

      ModelPemuat getPemuat = await modelPemuatFromJson(response.body);
      return getPemuat.data;
    } catch (e) {
      print(e);
    }
  }

}