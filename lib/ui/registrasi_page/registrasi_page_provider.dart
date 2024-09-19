import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/ui/login_page/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegistrasiPageProvider extends ChangeNotifier{

  String countryCode = '62';
  final GlobalKey<FormState> registrasiFormKey = GlobalKey<FormState>();
  bool _isObscurePassTxt = true;
  TextEditingController namaLengkapTxt = TextEditingController();
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController teleponTxt = TextEditingController();
  TextEditingController alamatDomisiliTxt = TextEditingController();
  TextEditingController alamatKebunTxt = TextEditingController();

  // isObscure Password
  bool get isObscurePass => _isObscurePassTxt;
  void inHidePassword() {
    _isObscurePassTxt = !_isObscurePassTxt;
    notifyListeners();
  }

  void selectCountry(String? value) {
    countryCode = value ?? '62';
    notifyListeners();
  }

  Future<void> addRegister(BuildContext context) async{
    try {
      final response = await http.post(Uri.parse(ApiConfig.url + "register-action"), body: {
        'name': namaLengkapTxt.text,
        'username': usernameTxt.text,
        'telp': countryCode + teleponTxt.text,
        'password': passwordTxt.text,
        'alamat_domisili': alamatDomisiliTxt.text,
        'alamat_kebun': alamatKebunTxt.text,
      });

      print(response.body);

      var addUserRegistrasi = await jsonDecode(response.body);

      if (addUserRegistrasi['success'] == true) {
        Fluttertoast.showToast(
            msg: "Anda berhasil melakukan registrasi akun",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPageView()), (route) => false);
      } else {
        String errorMessage = addUserRegistrasi['message'] ?? "Registrasi akun gagal. Silakan coba lagi.";
        Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red, // Menampilkan warna merah untuk kesalahan
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Terjadi kesalahan. Silakan coba lagi nanti.",
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