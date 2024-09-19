import 'dart:convert';

import 'package:app_sawit/api/api_config.dart';
import 'package:app_sawit/model/model_pinjaman.dart';
import 'package:app_sawit/ui/pinjaman_page/edit_pinjaman_page_view.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DetailPinjamanPageView extends StatefulWidget {
  final DataPinjaman data;

  DetailPinjamanPageView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailPinjamanPageView> createState() => _DetailPinjamanPageViewState();
}

class _DetailPinjamanPageViewState extends State<DetailPinjamanPageView> {

  Future<void> deletedDataPeminjaman() async{
    final response = await http.post(Uri.parse(ApiConfig.url + 'peminjaman/destroy/${widget.data.id}'));
    var deletedJadwal = await jsonDecode(response.body);

    if(deletedJadwal['status'] == 200){
      Fluttertoast.showToast(
          msg: "Anda berhasil menghapus data peminjaman",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PinjamanPageView()), (route) => false);
    }else{
      Fluttertoast.showToast(
          msg: "Maaf, Data belum berhasil di hapus",
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
  Widget build(BuildContext context) {
    DateTime? tglAwal = widget.data.tglAwal;
    DateTime? tglAkhir = widget.data.tglAkhir;

    // Memformat tanggal jika tidak null
    String formattedTglAwal = tglAwal != null
        ? DateFormat('d MMMM yyyy').format(tglAwal)
        : 'Tanggal tidak tersedia';
    String formattedTglAkhir = tglAkhir != null
        ? DateFormat('d MMMM yyyy').format(tglAkhir)
        : 'Tanggal tidak tersedia';
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
          "Detail Pinjaman #${widget.data.nomorPeminjaman}",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.data.nomorPeminjaman}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Nomor Pinjaman",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                            widget.data.status == 'Ditolak'
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        "${widget.data.status}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  )
                                : widget.data.status == 'Disetujui'
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Text(
                                            "${widget.data.status}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : widget.data.status == 'Proses'
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                "${widget.data.status}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          )
                                        : widget.data.status == 'Dikembalikan'
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Text(
                                                    "${widget.data.status}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : widget.data.status == 'Selesai'
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Text(
                                                        "${widget.data.status}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("Detail Pinjaman",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        Divider(),
                        SizedBox(height: 10),
                        Table(
                          children: [
                            TableRow(children: [
                              Text("Nama Lengkap",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                              Text("${widget.data.users?.name}",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                            ]),
                            TableRow(children: [
                              Text("Tanggal Mulai",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                              Text("${formattedTglAwal}",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                            ]),
                            TableRow(children: [
                              Text("Tanggal Selesai",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                              Text("${formattedTglAkhir}",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                            ]),
                            TableRow(children: [
                              Text("Nominal",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                              Text("Rp. ${widget.data.nominal},-",
                                  style: GoogleFonts.poppins(fontSize: 10)),
                            ]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text("Alasan :",
                            style: GoogleFonts.poppins(
                                fontSize: 10, fontWeight: FontWeight.w600)),
                        Text("${widget.data.alasan}",
                            style: GoogleFonts.poppins(fontSize: 10)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.data.status == 'Proses'
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditPinjamanPageView(
                            data: widget.data,
                          )));
                        },
                        height: 48,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.blue,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              "Edit Data",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      MaterialButton(
                        onPressed: () async{
                          await deletedDataPeminjaman();
                        },
                        height: 48,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.red,
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              "Hapus Data",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Padding(
            padding: const EdgeInsets.all(20),
            child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                color: Colors.blue,
                child: Text("Kembali", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ),
    );
  }
}
