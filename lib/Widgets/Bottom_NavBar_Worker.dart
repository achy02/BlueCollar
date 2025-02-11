import 'package:bluecollar/Utils/AppColors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottom_NavBar_Worker extends StatelessWidget {
  final int indexx;
  const Bottom_NavBar_Worker({super.key, required this.indexx});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: indexx,
      backgroundColor: AppColors.ThemeBlue2,
      items: <Widget>[
        Icon(Icons.home_rounded, size: 30),
        Icon(Icons.notifications_active_sharp, size: 30),
        Icon(Icons.account_circle_outlined, size: 30),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/workerHome", (route) => false);
            }
            break;
          case 1:
            print("$index == $indexx");
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/Received", (route) => false);
            }
            break;
          case 2:
            print("$index == $indexx");
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/workerEdit", (route) => false);
            }

            break;
        }
        print("Clicked+" + index.toString());
      },
    );
  }
}
