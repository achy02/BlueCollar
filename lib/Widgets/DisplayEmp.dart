import 'package:bluecollar/Pages/HomeScreen.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/EmployeeContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class DisplayEMP extends StatelessWidget {
  // final DocumentSnapshot dc;
  AsyncSnapshot<QuerySnapshot> streamSnapshot;
  final bool fav;
  final int distcheck;
  DisplayEMP({
    super.key,
    // required this.dc,
    this.fav = false,
    required this.streamSnapshot,
    this.distcheck = 50,
  });
  int _initialItemCount = 10;
  int _incrementAmount = 10;

  @override
  Widget build(BuildContext context) {
    if (streamSnapshot.data!.size > 0) {
      return ListView.builder(
          itemCount: streamSnapshot.data!.size,
          itemBuilder: (context, index) {
            final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];

            String img_url = streamSnapshot.data!.docs[index].get("img");
            // print("img is :" + img_url.toString());
            // print(streamSnapshot.data!.docs[index].id.toString());
            GeoPoint workerps =
                streamSnapshot.data!.docs[index].get("location");
            double distance = Geolocator.distanceBetween(
              HomeScreen.locationdata!.latitude,
              HomeScreen.locationdata!.longitude,
              workerps.latitude,
              workerps.longitude,
            );
            if (fav == false) {
              // print("My location is:" + HomeScreen.locationdata!.toString());

              // print("Distance is :" + (distance / 1000).round().toString());
              if ((distance / 1000).round() < distcheck) {
                return EmployeeContainer(
                  ds: documentSnapshot,
                  favs: fav,
                  img: img_url,
                  dist: (distance / 1000).round(),
                );
              } else {
                return Container();
              }
            } else {
              return EmployeeContainer(
                dist: (distance / 1000).round(),
                ds: documentSnapshot,
                favs: fav,
                img: img_url,
              );
            }
          });
      ;
    } else {
      return Container(
          child: BigText(
        text: "NO DATA",
      ));
    }
    ;
  }
}
