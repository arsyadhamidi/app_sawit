import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/ui/dashboard_page/dashboard_page_provider.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_view.dart';
import 'package:app_sawit/ui/penjualan_page/penjualan_page_view.dart';
import 'package:app_sawit/ui/petani_page/petani_page_view.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPageView extends StatelessWidget {
  const DashboardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardPageProvider(),
      child: Consumer<DashboardPageProvider>(
        builder: (context, dashboard, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 2,
              title: Text(
                "Halo, ${dataGlobal.user?.user?.name}",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none),
                    color: Colors.white),
              ],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Harga Berondolan",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                                Text(
                                  "Rp.${dashboard.hargaSawit?.data?.hargaBerondolan},-",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Harga TBS",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                                Text(
                                  "Rp.${dashboard.hargaSawit?.data?.hargaTbs},-",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 35, right: 35, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Fitur-Fitur",
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        Text("Semua",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.green)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PetaniPageView()));
                          },
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    "assets/images/petani.png",
                                    scale: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "Data Petani",
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JadwalPageView()));
                          },
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    "assets/images/calendar.png",
                                    scale: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "Jadwal Panen",
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PinjamanPageView()));
                          },
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    "assets/images/peminjaman.png",
                                    scale: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "Pinjaman",
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 35),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PenjualanPageView()));
                          },
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    "assets/images/penjualan.png",
                                    scale: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "Penjualan",
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
