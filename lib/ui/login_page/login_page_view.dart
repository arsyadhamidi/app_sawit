import 'package:app_sawit/ui/login_page/login_page_provider.dart';
import 'package:app_sawit/ui/registrasi_page/registrasi_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginPageProvider(),
      child: Consumer<LoginPageProvider>(
        builder: (context, login, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: login.loginFormKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: ListView(children: [
                        SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: 200,
                            height: 70,
                            child: Image(
                                image: AssetImage("assets/images/logo-1.png"),
                                fit: BoxFit.fill),
                          ),
                        ),

                        // Email Address
                        SizedBox(height: 40),
                        Text("Username",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: login.usernameTxt,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 16),
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Username",
                              hintStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon: Icon(CupertinoIcons.person_alt),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan masukan username anda.';
                            } else{
                              return null;
                            }
                          },
                        ),

                        // Password
                        SizedBox(height: 25),
                        Text("Password",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: login.passwordTxt,
                          obscureText: login.isObscureTxt,
                          decoration: InputDecoration(
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              filled: true,
                              hintText: "Masukan password",
                              prefixIcon: Icon(
                                CupertinoIcons.lock_fill,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  login.isObscureTxt
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  login.inHidePassword();
                                },
                              ),
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password wajib diisi';
                            } else if (value.length < 8) {
                              return 'Password minimal 8 karakter';
                            }
                            return null;
                          },
                        ),

                        //  Button
                        SizedBox(height: 50),
                        MaterialButton(
                          height: 48,
                          minWidth: 270,
                          color: Color.fromRGBO(55, 168, 53, 1),
                          onPressed: login.isLoading
                              ? null
                              : () {
                            if (login.loginFormKey.currentState
                                ?.validate() ==
                                true) {
                              login.loginAuth(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                          child: login.isLoading
                              ? CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue))
                              : Text(
                            "Masuk",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Anda belum punya akun ?", style: GoogleFonts.poppins(fontSize: 12),),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrasiPageView()));
                                },
                                child: Text(
                                  "Registrasi !",
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                      ])),
                ),
              ));
        },
      ),
    );
  }
}
