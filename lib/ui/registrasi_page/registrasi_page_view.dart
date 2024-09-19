import 'package:app_sawit/ui/login_page/login_page_view.dart';
import 'package:app_sawit/ui/registrasi_page/registrasi_page_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegistrasiPageView extends StatelessWidget {
  const RegistrasiPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrasiPageProvider(),
      child: Consumer<RegistrasiPageProvider>(
        builder: (context, registrasi, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: registrasi.registrasiFormKey,
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

                        // Nama Lengkap
                        SizedBox(height: 40),
                        Text("Nama Lengkap",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: registrasi.namaLengkapTxt,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 16),
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Nama Lengkap",
                              hintStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan masukan nama lengkap anda.';
                            } else{
                              return null;
                            }
                          },
                        ),

                        //Username
                        SizedBox(height: 25),
                        Text("Username",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: registrasi.usernameTxt,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 16),
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Username",
                              hintStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon: Icon(Icons.person),
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
                          controller: registrasi.passwordTxt,
                          obscureText: registrasi.isObscurePass,
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
                                  registrasi.isObscurePass
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  registrasi.inHidePassword();
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

                        // Telepon
                        SizedBox(height: 25),
                        Text("Nomor Telepon",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: registrasi.teleponTxt,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 16),
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Entry phone number",
                              hintStyle: GoogleFonts.poppins(fontSize: 12),
                              prefixIcon: DropdownButton<String>(
                                value: registrasi.countryCode,
                                onChanged: registrasi.selectCountry,
                                underline: Container(),
                                items: [
                                  DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                            Colors.grey.withOpacity(0.2),
                                            backgroundImage: AssetImage(
                                                'assets/images/malaysia.jpg'),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "+60",
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    value: '60',
                                  ),
                                  DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                              backgroundImage: AssetImage(
                                                  'assets/images/indonesia.jpg'),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "+62",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: '62'),
                                ],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan masukan nomor telepon anda.';
                            }
                            if (value.length < 10) {
                              return 'Masukan nomor telepon minimal 10 karakter';
                            } else {
                              return null;
                            }
                          },
                        ),

                        // Alamat Domisili
                        SizedBox(height: 25),
                        Text("Alamat Domisili",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: registrasi.alamatDomisiliTxt,
                          maxLines: 5,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Alamat Domisili",
                              hintStyle: GoogleFonts.poppins(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan masukan alamat domisili.';
                            } else{
                              return null;
                            }
                          },
                        ),

                        // Alamat Kebun
                        SizedBox(height: 25),
                        Text("Alamat Kebun",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: registrasi.alamatKebunTxt,
                          maxLines: 5,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: "Alamat Kebun",
                              hintStyle: GoogleFonts.poppins(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan masukan alamat kebun.';
                            } else{
                              return null;
                            }
                          },
                        ),

                        //  Button
                        SizedBox(height: 50),
                        MaterialButton(
                          height: 48,
                          minWidth: 270,
                          color: Color.fromRGBO(55, 168, 53, 1),
                          onPressed: () async {
                            if (registrasi.registrasiFormKey.currentState
                                ?.validate() ==
                                true) {
                              await registrasi.addRegister(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                          child: Text(
                            "Daftar",
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
                            Text("Sudah punya akun ?", style: GoogleFonts.poppins(fontSize: 12),),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageView()));
                                },
                                child: Text(
                                  "Login !",
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
