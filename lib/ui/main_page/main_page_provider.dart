import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/model/model_user.dart';
import 'package:app_sawit/ui/akun_page/akun_page_view.dart';
import 'package:app_sawit/ui/dashboard_page/dashboard_page_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageProvider extends ChangeNotifier{

  MainPageProvider(BuildContext context){
    getDataUser(context);
  }

  int selectedIndex = 0;
  Future<void> getDataUser(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email =  prefs.getString('dataUser');
    if (email != null) {
      dataGlobal.user = modelUserFromJson(email);
    }
  }

  void onItemTapped(int index){
    selectedIndex = index;
    notifyListeners();
  }

  static const List<Widget> selectbody = <Widget>[
    DashboardPageView(),
    AkunPageView(),
  ];


}