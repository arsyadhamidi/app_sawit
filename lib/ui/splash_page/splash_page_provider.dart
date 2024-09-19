import 'dart:async';

import 'package:app_sawit/ui/login_page/login_page_view.dart';
import 'package:flutter/material.dart';

class SplashPageProvider extends ChangeNotifier{

  SplashPageProvider(BuildContext context) {
    getAwal(context);
  }

  void getAwal(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      // var prefs = await SharedPreferences.getInstance();
      // var data = prefs.get("dataUser");
      Navigator.pushAndRemoveUntil(
        context,
        // MaterialPageRoute(builder: (context) => data != null ? MainPageView() : LoginPageView()),
        MaterialPageRoute(builder: (context) => LoginPageView()),
            (route) => false,
      );
    });
  }

}