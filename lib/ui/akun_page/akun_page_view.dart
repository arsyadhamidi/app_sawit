import 'package:app_sawit/global/global_key.dart';
import 'package:app_sawit/ui/splash_page/splash_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunPageView extends StatefulWidget {
  const AkunPageView({Key? key}) : super(key: key);

  @override
  State<AkunPageView> createState() => _AkunPageViewState();
}

class _AkunPageViewState extends State<AkunPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Account", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/petani.png")
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${dataGlobal.user?.user?.name}", style: GoogleFonts.poppins(fontSize: 14),),
                          Text("${dataGlobal.user?.user?.telp}", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),)
                        ],
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
              Spacer(),
              MaterialButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashPageView()), (route) => false);
                },
                color: Colors.red,
                minWidth: double.infinity,
                height: 48,
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Log Out", style: GoogleFonts.poppins(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
