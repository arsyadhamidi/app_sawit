import 'package:app_sawit/ui/jadwal_page/add_jadwal_page_view.dart';
import 'package:app_sawit/ui/jadwal_page/edit_jadwal_page_view.dart';
import 'package:app_sawit/ui/jadwal_page/jadwal_page_provider.dart';
import 'package:app_sawit/ui/main_page/main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class JadwalPageView extends StatelessWidget {
  const JadwalPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JadwalPageProvider(),
      child: Consumer<JadwalPageProvider>(
        builder: (context, jadwal, child) {
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
                "Jadwal Panen",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => jadwal.reloadJadwalPanen(),
              backgroundColor: Colors.white,
              color: Colors.blue,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: jadwal.isLoading
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
                                                  MainAxisAlignment.spaceBetween,
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
                        itemCount: jadwal.listJadwal?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditJadwalPageView(
                                  jadwal: jadwal.listJadwal![index],
                                )));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${jadwal.listJadwal?[index].petani?.nama}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                  "${jadwal.listJadwal?[index].waktuPanen} - ${jadwal.listJadwal?[index].luasKebun}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.grey)),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  "${jadwal.listJadwal?[index].lokasiKebun}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      textStyle: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic)),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  "${jadwal.listJadwal?[index].latitude} - ${jadwal.listJadwal?[index].longitude}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      textStyle: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () async{
                                                  await jadwal.deletedJadwalPanen(
                                                    context,
                                                    jadwal.listJadwal?[index].id.toString() ?? '',
                                                  );
                                                },
                                                icon: Icon(Icons.close, color: Colors.red,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddJadwalPageView()));
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
