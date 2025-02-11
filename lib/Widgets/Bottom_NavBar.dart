import 'package:bluecollar/Utils/AppColors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottom_NavBar extends StatelessWidget {
  final int indexx;
  const Bottom_NavBar({super.key, required this.indexx});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: indexx,
      backgroundColor: AppColors.ThemeBlue2,
      items: <Widget>[
        Icon(Icons.home_rounded, size: 30),
        Icon(Icons.favorite_outline, size: 30),
        Icon(Icons.search, size: 30),
        Icon(Icons.notifications_active_sharp, size: 30),
        Icon(Icons.account_circle_outlined, size: 30),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/Home", ModalRoute.withName('/Home'));
            }
            break;
          case 1:
            print("$index == $indexx");
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/favourites", ModalRoute.withName('/Home'));
            }

            break;
          case 2:
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/TypeGrid", ModalRoute.withName('/Home'));
            }

            break;
          case 3:
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/Requests", ModalRoute.withName('/Home'));
            }

            break;
          case 4:
            if (indexx == index) {
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/editHirer", ModalRoute.withName('/Home'));
            }

            break;
        }
        print("Clicked+" + index.toString());
      },
    );
    //   return Container(
    //     padding: EdgeInsets.all(10),
    //     height: 110,
    //     // ignore:sort_child_properties_last
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         GestureDetector(
    //           child: AspectRatio(
    //             aspectRatio: 1,
    //             child: Container(
    //               padding: EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.2),
    //                     spreadRadius: 1,
    //                     blurRadius: 1,
    //                     offset: Offset(0, -3), // changes position of shadow
    //                   ),
    //                 ],
    //               ),
    //               child: Column(children: [
    //                 // ignore: prefer_const_constructos
    //                 Icon(
    //                   Icons.star_border_rounded,
    //                   size: 35,
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 BigText(
    //                   text: "Favourites",
    //                   size: 15,
    //                   fw: FontWeight.bold,
    //                 ),
    //               ]),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           child: AspectRatio(
    //             aspectRatio: 1,
    //             child: Container(
    //               padding: EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.2),
    //                     spreadRadius: 1,
    //                     blurRadius: 1,
    //                     offset: Offset(0, -3), // changes position of shadow
    //                   ),
    //                 ],
    //               ),
    //               child: Column(children: [
    //                 // ignore: prefer_const_constructos
    //                 Icon(
    //                   Icons.home_rounded,
    //                   size: 35,
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 BigText(
    //                   text: "Home",
    //                   size: 15,
    //                   fw: FontWeight.bold,
    //                 ),
    //               ]),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           child: AspectRatio(
    //             aspectRatio: 1,
    //             child: Container(
    //               padding: EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.2),
    //                     spreadRadius: 1,
    //                     blurRadius: 1,
    //                     offset: Offset(0, -3), // changes position of shadow
    //                   ),
    //                 ],
    //               ),
    //               child: Column(children: [
    //                 // ignore: prefer_const_constructos
    //                 Icon(
    //                   Icons.account_circle_outlined,
    //                   size: 35,
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 BigText(
    //                   text: "Profile",
    //                   size: 15,
    //                   fw: FontWeight.bold,
    //                 ),
    //               ]),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       // boxShadow: [
    //       //   BoxShadow(
    //       //     color: Colors.black.withOpacity(0.6),
    //       //     spreadRadius: 2,
    //       //     blurRadius: 2,
    //       //     offset: Offset(0, -2), // changes position of shadow
    //       //   ),
    //       // ],
    //     ),
    //   );
  }
}
