import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/model/model_data_petani.dart';
import 'package:app_sawit/ui/petani_page/petani_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditPetaniPageView extends StatefulWidget {
  final ModelDataPetani dataPetani;
  EditPetaniPageView({Key? key, required this.dataPetani}) : super(key: key);

  @override
  State<EditPetaniPageView> createState() => _EditPetaniPageViewState();
}

class _EditPetaniPageViewState extends State<EditPetaniPageView> {

  TextEditingController namaText = TextEditingController();
  TextEditingController teleponText = TextEditingController();
  TextEditingController alamatDomisiliText = TextEditingController();
  TextEditingController alamatKebunText = TextEditingController();
  
  Future<void> updateDataPetani() async{
    final response = await http.post(Uri.parse(ApiConfig.url + "data-petani/update/${widget.dataPetani.data?.id}"), body: {
      'nama': namaText.text,
      'telp': teleponText.text,
      'alamat_domisili': alamatDomisiliText.text,
      'alamat_kebun': alamatKebunText.text,
    });

    var updatePetani = await jsonDecode(response.body);

    if(updatePetani['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil memperbaharui data petani",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PetaniPageView()), (route) => false);
    }else{
      Fluttertoast.showToast(
          msg: "Maaf, Data belum berhasil di perbaharui",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  void initState() {
    namaText = TextEditingController(text: widget.dataPetani.data?.nama);
    teleponText = TextEditingController(text: widget.dataPetani.data?.telp);
    alamatDomisiliText = TextEditingController(text: widget.dataPetani.data?.alamatDomisili);
    alamatKebunText = TextEditingController(text: widget.dataPetani.data?.alamatKebun);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Edit Data Petani",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Lengkap
                Text("Nama Lengkap",
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                TextFormField(
                  controller: namaText,
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

                // Telepon
                SizedBox(height: 25),
                Text("Nomor Telepon",
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: teleponText,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      filled: true,
                      fillColor: Color.fromRGBO(243, 243, 243, 1),
                      hintText: "Nomor Telepon",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukan nomor telepon anda.';
                    } else{
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
                  controller: alamatDomisiliText,
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
                  controller: alamatKebunText,
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: () async {
            await updateDataPetani();
          },
          height: 50,
          minWidth: double.infinity,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Simpan Data", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),),
        ),
      ),
    );
  }
}
