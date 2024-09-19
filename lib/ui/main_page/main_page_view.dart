import 'package:app_sawit/ui/main_page/main_page_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(context),
      child: Consumer<MainPageProvider>(
        builder: (context, mainProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: MainPageProvider.selectbody.elementAt(mainProvider.selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: mainProvider.selectedIndex,
              onTap: mainProvider.onItemTapped,
              selectedItemColor: Colors.green,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  label: "Akun",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
