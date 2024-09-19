import 'package:app_sawit/ui/main_page/main_page_view.dart';
import 'package:app_sawit/ui/penjualan_page/add_penjualan_page_view.dart';
import 'package:app_sawit/ui/penjualan_page/penjualan_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PenjualanPageView extends StatelessWidget {
  const PenjualanPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PenjualanPageProvider(),
      child: Consumer<PenjualanPageProvider>(
        builder: (context, penjualan, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 2,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPageView()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              title: Text(
                "Penjualan",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: penjualan.reloadDataPenjualan,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: penjualan.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: List.generate(
                                  6,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.grey.shade200)),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: Colors.green,
                                                      size: 15,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      width: 150,
                                                      height: 20,
                                                      color: Colors.grey[300],
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: penjualan.listPenjualan?.length ?? 0,
                        itemBuilder: (context, index) {
                          DateTime? tanggal =
                              penjualan.listPenjualan?[index].tanggal;
                          // Memformat tanggal jika tidak null
                          String formattedTanggal = tanggal != null
                              ? DateFormat('d MMMM yyyy').format(tanggal)
                              : 'Tanggal tidak tersedia';
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${formattedTanggal}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)),
                                    Text(
                                        "Supir : ${penjualan.listPenjualan?[index].supir?.nama}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Pemuat : ${penjualan.listPenjualan?[index].pemuat?.nama}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Quantity TBS : ${penjualan.listPenjualan?[index].quantityTbs}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Total TBS : Rp. ${penjualan.listPenjualan?[index].totalTbs},-",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Quantity Berondolan : ${penjualan.listPenjualan?[index].quantityBerondolan}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Total Berondolan : Rp. ${penjualan.listPenjualan?[index].totalBerondolan},-",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                    Text(
                                        "Total Harga : Rp. ${penjualan.listPenjualan?[index].totalPembelian},-",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPenjualanPageView()));
              },
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
