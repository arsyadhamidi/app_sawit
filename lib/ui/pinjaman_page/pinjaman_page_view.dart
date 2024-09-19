import 'package:app_sawit/ui/main_page/main_page_view.dart';
import 'package:app_sawit/ui/pinjaman_page/add_pinjaman_page_view.dart';
import 'package:app_sawit/ui/pinjaman_page/detail_pinjaman_page_view.dart';
import 'package:app_sawit/ui/pinjaman_page/pinjaman_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PinjamanPageView extends StatelessWidget {
  const PinjamanPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PinjamanPageProvider(),
      child: Consumer<PinjamanPageProvider>(
        builder: (context, pinjaman, child) {
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
                "Pinjaman",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => pinjaman.reloadPinjaman(),
              backgroundColor: Colors.white,
              color: Colors.blue,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: pinjaman.isLoading
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
                                                    color:
                                                        Colors.grey.shade200)),
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
                          itemCount: pinjaman.listPinjaman?.length ?? 0,
                          itemBuilder: (context, index) {
                            DateTime? tglAwal = pinjaman.listPinjaman?[index].tglAwal;
                            DateTime? tglAkhir = pinjaman.listPinjaman?[index].tglAkhir;
                            // Memformat tanggal jika tidak null
                            String formattedTglAwal = tglAwal != null
                                ? DateFormat('d MMMM yyyy').format(tglAwal)
                                : 'Tanggal tidak tersedia';
                            String formattedTglAkhir = tglAkhir != null
                                ? DateFormat('d MMMM yyyy').format(tglAkhir)
                                : 'Tanggal tidak tersedia';
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPinjamanPageView(
                                                  data: pinjaman
                                                      .listPinjaman![index])));
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(),
                                  ),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                "${pinjaman.listPinjaman?[index].users?.name}",
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                            pinjaman.listPinjaman?[index]
                                                        .status ==
                                                    'Ditolak'
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
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
                                                        "${pinjaman.listPinjaman?[index].status}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  )
                                                : pinjaman.listPinjaman?[index]
                                                            .status ==
                                                        'Disetujui'
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Text(
                                                            "${pinjaman.listPinjaman?[index].status}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      )
                                                    : pinjaman
                                                                .listPinjaman?[
                                                                    index]
                                                                .status ==
                                                            'Proses'
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.yellow,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Text(
                                                                "${pinjaman.listPinjaman?[index].status}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ),
                                                          )
                                                        : pinjaman
                                                                    .listPinjaman?[
                                                                        index]
                                                                    .status ==
                                                                'Dikembalikan'
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .orange,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  child: Text(
                                                                    "${pinjaman.listPinjaman?[index].status}",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              )
                                                            : pinjaman
                                                                        .listPinjaman?[
                                                                            index]
                                                                        .status ==
                                                                    'Selesai'
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        "${pinjaman.listPinjaman?[index].status}",
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(), // Untuk menangani status lainnya jika ada
                                          ],
                                        ),
                                        Text(
                                          "No. ${pinjaman.listPinjaman?[index].nomorPeminjaman}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          "${formattedTglAwal} - ${formattedTglAkhir}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPinjamanPageView()));
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white,),
            ),
          );
        },
      ),
    );
  }
}
