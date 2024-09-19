import 'package:app_sawit/model/model_pinjaman.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:flutter/material.dart';

class PinjamanPageProvider extends ChangeNotifier{

  bool isLoading = false;
  List<DataPinjaman>? listPinjaman;

  PinjamanPageProvider(){
    listDataPinjaman();
  }

  Future<List<DataPinjaman>?> listDataPinjaman () async{
    try{
      isLoading = true;
      notifyListeners();

      final response  = await NetworkProvider().getDataPinjaman();
      listPinjaman = response?.data ?? [];
      // print(listContent);

      isLoading = false;
      notifyListeners();
      return listPinjaman;
    }catch(e){
      print(e);
      isLoading = true;
      notifyListeners();
    }
  }

  Future<void> reloadPinjaman() async {
    await listDataPinjaman();
  }

}