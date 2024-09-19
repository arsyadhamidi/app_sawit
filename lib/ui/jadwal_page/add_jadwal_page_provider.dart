import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddJadwalPageProvider extends ChangeNotifier {
  AddJadwalPageProvider() {}

  String? _selectedValue;
  final GlobalKey<FormState> addJadwalFormKey = GlobalKey<FormState>();
  TextEditingController luasKebunTxt = TextEditingController();
  TextEditingController lokasiKebunTxt = TextEditingController();
  TextEditingController latitudeTxt = TextEditingController();
  TextEditingController longitudeTxt = TextEditingController();

  String? get selectedValue => _selectedValue;
  void selectValue(String? newValue) {
    _selectedValue = newValue;
    notifyListeners(); // Memberitahukan listener bahwa state telah berubah
  }

  // Daftar opsi untuk dropdown
  final List<String> options = [
    'Per 1 Minggu',
    'Per 2 Minggu',
    'Per 3 Minggu',
    'Per 4 Minggu',
  ];

  Future<void> addJadwalPanen(BuildContext context) async {
    final response =
        await http.post(Uri.parse(ApiConfig.url + "jadwal-panen/store"), body: {
      'users_id': dataGlobal.user?.user?.id.toString() ?? '',
      'waktu_panen': selectedValue.toString(),
      'luas_kebun': luasKebunTxt.text,
      'lokasi_kebun': lokasiKebunTxt.text,
      'latitude': latitudeTxt.text,
      'longitude': longitudeTxt.text,
    });

    var addJadwal = await jsonDecode(response.body);
    if(addJadwal['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil menambahkan jadwal panen",
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
          msg: "Maaf, Anda belum berhasil menambahkan data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
