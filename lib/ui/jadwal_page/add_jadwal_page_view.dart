import 'package:app_sawit/ui/jadwal_page/add_jadwal_page_provider.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddJadwalPageView extends StatelessWidget {
  const AddJadwalPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddJadwalPageProvider(),
      child: Consumer<AddJadwalPageProvider>(
        builder: (context, addJadwal, child) {
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
                "Tambah Jadwal Panen",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: Form(
              key: addJadwal.addJadwalFormKey,
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
                              value: addJadwal.selectedValue,
                              style: GoogleFonts.poppins(
                                color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(20),
                              onChanged: (String? newValue) {
                                addJadwal.selectValue(newValue);
                              },
                              items: addJadwal.options
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
                          controller: addJadwal.luasKebunTxt,
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
                          controller: addJadwal.lokasiKebunTxt,
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
                          controller: addJadwal.latitudeTxt,
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
                          controller: addJadwal.longitudeTxt,
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
                  if (addJadwal.addJadwalFormKey.currentState
                      ?.validate() ==
                      true) {
                    await addJadwal.addJadwalPanen(context);
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
        },
      ),
    );
  }
}
