import 'package:app_sawit/ui/pinjaman_page/add_pinjaman_page_provider.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddPinjamanPageView extends StatelessWidget {
  const AddPinjamanPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPinjamanPageProvider(),
      child: Consumer<AddPinjamanPageProvider>(
        builder: (context, addPinjaman, child) {
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
                "Ajukan Pinjaman",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: Form(
              key: addPinjaman.addPinjamanFormKey,
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
                          controller: addPinjaman.tglAwalTxt,
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
                              addPinjaman.setDateAwal(pickedDate);
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
                          controller: addPinjaman.tglAkhirTxt,
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
                              addPinjaman.setDateAkhir(pickedDate);
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
                          controller: addPinjaman.nominalTxt,
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
                          controller: addPinjaman.alasanTxt,
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
                onPressed: () async{
                  if (addPinjaman.addPinjamanFormKey.currentState
                      ?.validate() ==
                      true) {
                    await addPinjaman.addDataPinjaman(context);
                  }
                },
                child: Text("Simpan Data", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),),
                minWidth: double.infinity,
                color: Colors.green,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
