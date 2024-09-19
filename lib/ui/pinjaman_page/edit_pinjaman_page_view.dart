import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/model/model_pinjaman.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditPinjamanPageView extends StatefulWidget {
  final DataPinjaman data;

  EditPinjamanPageView({Key? key, required this.data}) : super(key: key);

  @override
  State<EditPinjamanPageView> createState() => _EditPinjamanPageViewState();
}

class _EditPinjamanPageViewState extends State<EditPinjamanPageView> {
  DateTime? _selectedDateAwal;
  DateTime? _selectedDateAkhir;
  final GlobalKey<FormState> editPinjamanFormKey = GlobalKey<FormState>();
  late TextEditingController tglAwalTxt;
  late TextEditingController tglAkhirTxt;
  late TextEditingController nominalTxt;
  late TextEditingController alasanTxt;

  void setDateAwal(DateTime date) {
    setState(() {
      _selectedDateAwal = date;
      tglAwalTxt.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  void setDateAkhir(DateTime date) {
    setState(() {
      _selectedDateAkhir = date;
      tglAkhirTxt.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  Future<void> editDataPinjaman(BuildContext context) async {
    final response = await http.post(
        Uri.parse(ApiConfig.url + 'peminjaman/update/${widget.data.id}'),
        body: {
          'users_id': dataGlobal.user?.user?.id.toString() ?? '',
          'tgl_awal': tglAwalTxt.text,
          'tgl_akhir': tglAkhirTxt.text,
          'nominal': nominalTxt.text,
          'alasan': alasanTxt.text
        });

    var addPinjaman = await jsonDecode(response.body);

    if (addPinjaman['status'] == 200) {
      Fluttertoast.showToast(
          msg: "Anda berhasil mempebaharui jadwal panen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PinjamanPageView()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Maaf, Anda belum berhasil memperbaharui data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();

    // Inisialisasi controllers dengan data yang ada
    tglAwalTxt = TextEditingController(
        text: widget.data.tglAwal != null
            ? DateFormat('yyyy-MM-dd').format(widget.data.tglAwal!)
            : '');
    tglAkhirTxt = TextEditingController(
        text: widget.data.tglAkhir != null
            ? DateFormat('yyyy-MM-dd').format(widget.data.tglAkhir!)
            : '');
    nominalTxt = TextEditingController(text: widget.data.nominal.toString());
    alasanTxt = TextEditingController(text: widget.data.alasan.toString());
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
              MaterialPageRoute(builder: (context) => PinjamanPageView()),
              (route) => false,
            );
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Edit Pinjaman",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ),
      body: Form(
        key: editPinjamanFormKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tanggal Mulai
                  Text("Tanggal Mulai",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: tglAwalTxt,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "Masukan tanggal mulai",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        prefixIcon: Icon(
                          CupertinoIcons.calendar,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setDateAwal(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Mulai wajib diisi';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),
                  // Tanggal Selesai
                  Text("Tanggal Selesai",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: tglAkhirTxt,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "Masukan tanggal selesai",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        prefixIcon: Icon(
                          CupertinoIcons.calendar,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setDateAkhir(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Selesai wajib diisi';
                      }
                      return null;
                    },
                  ),

                  //  Nominal
                  SizedBox(height: 20),
                  Text("Nominal",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nominalTxt,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Masukan nominal",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        prefixIcon: Icon(
                          CupertinoIcons.money_dollar,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal wajib diisi';
                      }
                      return null;
                    },
                  ),

                  //  Alasan
                  SizedBox(height: 20),
                  Text("Alasan",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: alasanTxt,
                    decoration: InputDecoration(
                        hintText: "Masukan alasan",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alasan wajib diisi';
                      }
                      return null;
                    },
                    maxLines: 5,
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
            if (editPinjamanFormKey.currentState?.validate() == true) {
              await editDataPinjaman(context);
            }
          },
          child: Text(
            "Simpan Data",
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          minWidth: double.infinity,
          color: Colors.green,
          height: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
