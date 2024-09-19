import 'package:app_sawit/model/model_penjualan.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:flutter/material.dart';

class PenjualanPageProvider extends ChangeNotifier{

  bool isLoading = false;
  List<DataPenjualan>? listPenjualan;

  PenjualanPageProvider(){
    listDataPenjualan();
  }

  Future<List<DataPenjualan>?> listDataPenjualan () async{
    try{
      isLoading = true;
      notifyListeners();

      final response  = await NetworkProvider().getDataPenjualan();
      listPenjualan = response?.data ?? [];
      // print(listContent);

      isLoading = false;
      notifyListeners();
      return listPenjualan;
    }catch(e){
      print(e);
      isLoading = true;
      notifyListeners();
    }
  }

  Future<void> reloadDataPenjualan() async {
    await listDataPenjualan();
  }

}