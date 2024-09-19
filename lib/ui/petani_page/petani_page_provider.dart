import 'package:app_sawit/model/model_data_petani.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:flutter/material.dart';

class PetaniPageProvider extends ChangeNotifier{

  ModelDataPetani? _dataPetani;
  ModelDataPetani? get dataPetani => _dataPetani;

  PetaniPageProvider(){
    getFirstDataPetani();
  }

  Future<void> getFirstDataPetani() async {
    try {
      final response = await NetworkProvider().getDataPetani();
      if (response != null) {
        _dataPetani = response;
      } else {
        // Handle the case where no data was returned
        _dataPetani = null;
      }
      notifyListeners();
    } catch (e) {
      // Handle any errors
      print('Error fetching data: $e');
      _dataPetani = null;
      notifyListeners();
    }
  }

  Future<void> reloadDataPetani() async {
    await getFirstDataPetani();
  }

}