import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/model/model_user.dart';
import 'package:app_sawit/ui/main_page/main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPageProvider extends ChangeNotifier{

  bool _isObscureTxt = true;
  bool isLoading = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController usernameTxt = TextEditingController();
  final TextEditingController passwordTxt = TextEditingController();

  bool get isObscureTxt => _isObscureTxt;

  void inHidePassword() {
    _isObscureTxt = !_isObscureTxt;
    notifyListeners();
  }

  Future<void> loginAuth(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final response =
      await http.post(Uri.parse(ApiConfig.url + "login-action"), body: {
        'username': usernameTxt.text,
        'password': passwordTxt.text,
      });

      // print(response.body);

      if (response.statusCode == 200) {
        ModelUser getDataUser = modelUserFromJson(response.body);

        print(getDataUser);

        if (getDataUser.success == true) {
          await saveSharedPreference(getDataUser);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPageView()),
                  (route) => false);
        } else {
          Fluttertoast.showToast(
            msg: "Maaf, login tidak berhasil. Mari kita coba lagi. Testing",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan pada server. Silakan coba lagi nanti.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan. Silakan coba lagi nanti.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveSharedPreference(ModelUser getDataUser) async {
    SharedPreferences prefsUser = await SharedPreferences.getInstance();
    prefsUser.setString("dataUser", jsonEncode(getDataUser));
  }

}