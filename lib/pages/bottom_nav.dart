import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_crypto_app/pages/home_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int currentIndex = 0;
List<Widget> pages = [HomePage(), HomePage(), HomePage(), HomePage()];

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 25.sp,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: currentIndex == 0
                    ? Icon(
                        Icons.home,
                      )
                    : Icon(Icons.home_outlined),
                label: 'home'),
            BottomNavigationBarItem(
                icon: currentIndex == 1
                    ? Icon(Icons.note)
                    : Icon(Icons.note_alt_outlined),
                label: 'home'),
            BottomNavigationBarItem(
                icon: currentIndex == 2
                    ? Icon(Icons.notifications_active)
                    : Icon(Icons.notifications),
                label: 'home'),
            BottomNavigationBarItem(
                icon: currentIndex == 3
                    ? Icon(Icons.person_2)
                    : Icon(Icons.person_2_outlined),
                label: 'home'),
          ]),
    );
  }
}
