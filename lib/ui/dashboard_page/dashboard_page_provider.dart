import 'package:app_sawit/model/model_harga_sawit.dart';
import 'package:app_sawit/network/network_provider.dart';
import 'package:flutter/material.dart';

class DashboardPageProvider extends ChangeNotifier {
  DashboardPageProvider() {
    getFirstHargaSawit();
  }

  ModelHargaSawit? _hargaSawit;
  ModelHargaSawit? get hargaSawit => _hargaSawit;

  Future<void> getFirstHargaSawit() async {
    try {
      final response = await NetworkProvider().getDataHargaSawit();
      if (response != null) {
        _hargaSawit = response;
      } else {
        // Handle the case where no data was returned
        _hargaSawit = null;
      }
      notifyListeners();
    } catch (e) {
      // Handle any errors
      print('Error fetching data: $e');
      _hargaSawit = null;
      notifyListeners();
    }
  }
}
