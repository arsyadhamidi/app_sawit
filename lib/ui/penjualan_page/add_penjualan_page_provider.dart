import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/model/model_pemuat.dart';
import 'package:app_sawit/model/model_supir.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:app_sawit/ui/penjualan_page/penjualan_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddPenjualanPageProvider extends ChangeNotifier{

  List<DataSupir> listSupir = [];
  List<DataPemuat> listPemuat = [];
  DateTime? _selectedDate;
  String? selectedSupir;
  String? selectedPemuat;
  final GlobalKey<FormState> addPenjualanFormKey = GlobalKey<FormState>();
  TextEditingController tanggalTxt = TextEditingController();
  TextEditingController quantityTbsTxt = TextEditingController();
  TextEditingController quantityBerondolanTxt = TextEditingController();

  AddPenjualanPageProvider(){
    listDataPemuat();
    listDataSupir();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    tanggalTxt.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  Future<void> listDataSupir() async {
    try {
      await NetworkProvider().getDataSupir().then((value) {
        listSupir = value ?? [];
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> listDataPemuat() async {
    try {
      await NetworkProvider().getDataPemuat().then((value) {
        listPemuat = value ?? [];
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addDataPenjualan(BuildContext context) async{
    final response = await http.post(Uri.parse(ApiConfig.url + 'penjualan/store/${dataGlobal.user?.user?.id}'), body: {
      'supir_id': selectedSupir.toString(),
      'pemuat_id': selectedPemuat.toString(),
      'tanggal': tanggalTxt.text.toString(),
      'quantity_tbs': quantityTbsTxt.text.toString(),
      'quantity_berondolan': quantityBerondolanTxt.text.toString(),
    });

    var addPenjualan = await jsonDecode(response.body);

    if(addPenjualan['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil menambahkan hasil penjualan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PenjualanPageView()),
              (route) => false);
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