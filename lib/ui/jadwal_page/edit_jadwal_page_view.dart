import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/model/model_jadwal_panen.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditJadwalPageView extends StatefulWidget {
  final DataJadwal jadwal;
  EditJadwalPageView({Key? key, required this.jadwal}) : super(key: key);

  @override
  State<EditJadwalPageView> createState() => _EditJadwalPageViewState();
}

class _EditJadwalPageViewState extends State<EditJadwalPageView> {

  String? _selectedValue;
  final GlobalKey<FormState> addJadwalFormKey = GlobalKey<FormState>();
  TextEditingController luasKebunTxt = TextEditingController();
  TextEditingController lokasiKebunTxt = TextEditingController();
  TextEditingController latitudeTxt = TextEditingController();
  TextEditingController longitudeTxt = TextEditingController();

  String? get selectedValue => _selectedValue;
  void selectValue(String? newValue) {
    setState(() {
      _selectedValue = newValue;
    }); // Memberitahukan listener bahwa state telah berubah
  }

  // Daftar opsi untuk dropdown
  List<String> options = [
    'Per 1 Minggu',
    'Per 2 Minggu',
    'Per 3 Minggu',
    'Per 4 Minggu',
  ];

  Future<void> addJadwalPanen(BuildContext context) async {
    final response =
    await http.post(Uri.parse(ApiConfig.url + "jadwal-panen/update/${widget.jadwal.id}"), body: {
      'users_id': dataGlobal.user?.user?.id.toString() ?? '',
      'waktu_panen': selectedValue.toString(),
      'luas_kebun': luasKebunTxt.text,
      'lokasi_kebun': lokasiKebunTxt.text,
      'latitude': latitudeTxt.text,
      'longitude': longitudeTxt.text,
    });

    var addJadwal = await jsonDecode(response.body);
    if(addJadwal['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil memperbaharui jadwal panen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => JadwalPageView()), (route) => false);
    }else{
      Fluttertoast.showToast(
          msg: "Maaf, Anda belum berhasil menambahkan data",
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
    _selectedValue = options.contains(widget.jadwal.waktuPanen) ? widget.jadwal.waktuPanen : null;
    luasKebunTxt = TextEditingController(text: widget.jadwal.luasKebun);
    lokasiKebunTxt = TextEditingController(text: widget.jadwal.lokasiKebun);
    latitudeTxt = TextEditingController(text: widget.jadwal.latitude);
    longitudeTxt = TextEditingController(text: widget.jadwal.longitude);
    super.initState();
  }

  @override
  void dispose() {
    // Bersihkan controller ketika widget dihapus
    luasKebunTxt.dispose();
    lokasiKebunTxt.dispose();
    latitudeTxt.dispose();
    longitudeTxt.dispose();
    super.dispose();
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => JadwalPageView()),
                  (route) => false,
            );
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Edit Jadwal Panen",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
      body: Form(
        key: addJadwalFormKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Waktu Panen",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        style: GoogleFonts.poppins(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                        onChanged: (String? newValue) {
                          selectValue(newValue);
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text('Pilih Waktu Panen'),
                        underline: Container(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text("Luas Kebun",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: luasKebunTxt,
                    decoration: InputDecoration(
                        hintText: "Masukan luas kebun",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan masukan luas kebun anda.';
                      } else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  Text("Lokasi Kebun",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: lokasiKebunTxt,
                    decoration: InputDecoration(
                        hintText: "Masukan lokasi kebun",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan masukan lokasi kebun anda.';
                      } else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  Text("Latitude",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: latitudeTxt,
                    decoration: InputDecoration(
                        hintText: "Masukan latitude",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan masukan latitude anda.';
                      } else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  Text("Longitude",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: longitudeTxt,
                    decoration: InputDecoration(
                        hintText: "Masukan longitude",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan masukan longitude anda.';
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: () async {
            if (addJadwalFormKey.currentState
                ?.validate() ==
                true) {
              await addJadwalPanen(context);
            }
          },
          height: 50,
          minWidth: double.infinity,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Simpan Data", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),),
        ),
      ),
    );
  }
}
