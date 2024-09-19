import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddPinjamanPageProvider extends ChangeNotifier {
  DateTime? _selectedDateAwal;
  DateTime? _selectedDateAkhir;
  final GlobalKey<FormState> addPinjamanFormKey = GlobalKey<FormState>();
  TextEditingController tglAwalTxt = TextEditingController();
  TextEditingController tglAkhirTxt = TextEditingController();
  TextEditingController nominalTxt = TextEditingController();
  TextEditingController alasanTxt = TextEditingController();

  void setDateAwal(DateTime date) {
    _selectedDateAwal = date;
    tglAwalTxt.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void setDateAkhir(DateTime date) {
    _selectedDateAkhir = date;
    tglAkhirTxt.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  Future<void> addDataPinjaman(BuildContext context) async {
    final response =
        await http.post(Uri.parse(ApiConfig.url + 'peminjaman/store'), body: {
      'users_id': dataGlobal.user?.user?.id.toString() ?? '',
      'tgl_awal': tglAwalTxt.text,
      'tgl_akhir': tglAkhirTxt.text,
      'nominal': nominalTxt.text,
      'alasan': alasanTxt.text
    });

    var addPinjaman = await jsonDecode(response.body);

    if (addPinjaman['status'] == 200) {
      Fluttertoast.showToast(
          msg: "Anda berhasil menambahkan jadwal panen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PinjamanPageView()),
          (route) => false);
    } else {
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
