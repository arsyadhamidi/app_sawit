import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/ui/main_page/main_page_view.dart';
import 'package:app_sawit/ui/petani_page/edit/edit_petani_page_view.dart';
import 'package:app_sawit/ui/petani_page/petani_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PetaniPageView extends StatelessWidget {
  const PetaniPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PetaniPageProvider(),
      child: Consumer<PetaniPageProvider>(
        builder: (context, petani, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 2,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPageView()), (route) =>  false,);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              title: Text(
                "Data Petani",
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => petani.reloadDataPetani(),
              color: Colors.blue,
              backgroundColor: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "UD Sawit Dongan",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.verified, color: Colors.blue,),
                                ],
                              ),
                              SizedBox(height: 20),
                              Table(
                                children: [
                                  TableRow(
                                      children: [
                                        Text(
                                          "Nama Petani :",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text("${petani.dataPetani?.data?.nama}", style: GoogleFonts.poppins(fontSize: 12),),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Text(
                                          "Username :",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text("${petani.dataPetani?.data?.users?.username}", style: GoogleFonts.poppins(fontSize: 12),),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Text(
                                          "Telepon :",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text("${petani.dataPetani?.data?.telp}", style: GoogleFonts.poppins(fontSize: 12),),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Text(
                                          "Alamat Domisili :",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text("${petani.dataPetani?.data?.alamatDomisili}", style: GoogleFonts.poppins(fontSize: 12),),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Text(
                                          "Alamat Kebun :",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text("${petani.dataPetani?.data?.alamatKebun}", style: GoogleFonts.poppins(fontSize: 12),),
                                      ]
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPetaniPageView(
                        dataPetani: petani.dataPetani!,
                      ),
                    ),
                  );
                },
                height: 50,
                minWidth: double.infinity,
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Edit Data Petani", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),),
              ),
            ),
          );
        },
      ),
    );
  }
}
