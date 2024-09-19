import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/model/model_jadwal_panen.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class JadwalPageProvider extends ChangeNotifier{

  bool isLoading = false;
  List<DataJadwal>? listJadwal;

  JadwalPageProvider(){
    listDataJadwalPanen();
  }

  Future<List<DataJadwal>?> listDataJadwalPanen () async{
    try{
      isLoading = true;
      notifyListeners();

      final response  = await NetworkProvider().getJadwalPanen();
      listJadwal = response?.data ?? [];
      // print(listContent);

      isLoading = false;
      notifyListeners();
      return listJadwal;
    }catch(e){
      print(e);
      isLoading = true;
      notifyListeners();
    }
  }

  Future<void> deletedJadwalPanen(BuildContext context, String id) async{
    final response = await http.post(Uri.parse(ApiConfig.url + 'jadwal-panen/destroy/${id}'));
    var deletedJadwal = await jsonDecode(response.body);

    if(deletedJadwal['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil menghapus jadwal panen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => JadwalPageView()), (route) => false);
    }else{
      Fluttertoast.showToast(
          msg: "Maaf, Data belum berhasil di hapus",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> reloadJadwalPanen() async {
    await listDataJadwalPanen();
  }

}