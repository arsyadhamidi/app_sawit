import 'package:app_sawit/ui/splash_page/splash_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashPageView extends StatelessWidget {
  const SplashPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashPageProvider(context),
      child: Consumer<SplashPageProvider>(
        builder: (context, splash, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Spacer(),
                  Image.asset("assets/images/logo-1.png", height: 100, width: 400,),
                  Spacer(),
                  Text("Only This", style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
