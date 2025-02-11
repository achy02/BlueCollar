import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:geodesy/geodesy.dart';

class page_Landing extends StatefulWidget {
  @override
  const page_Landing({super.key});
  page_LandingState createState() => page_LandingState();
}

class page_LandingState extends State<page_Landing> {
  static bool _username = true;
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkPermissions().then((value) {
      Future.delayed(Duration.zero, () {
        // print("Checking in landing 1" +
        //     FirebaseAuth.instance.currentUser!.uid.toString());

        if (auth.currentUser != null) {
          try {
            print("Checking inside not null");
            check();
          } catch (e) {
            print("Inside exceptiondsaaaaaaaaaaaaaaaaa");
            print(e);
          }
        } else {
          print("inside else: is null");
          // FirebaseAuth.instance.currentUser!.uid.toString());
          Navigator.pushNamedAndRemoveUntil(
              context, '/Role', ModalRoute.withName('/Role'));
        }
      });
    });
  }

  Future<void> checkPermissions() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      await requestCameraPermission();
    }
    final locationStatus = await Permission.locationWhenInUse.status;
    if (!locationStatus.isGranted) {
      await requestLocationPermission();
    }
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      showPermissionDeniedDialog('camera');
    }
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isDenied) {
      showPermissionDeniedDialog('location');
    }
  }

  void showPermissionDeniedDialog(String permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Permission denied'),
        content: Text(
            'Please go to app settings and enable $permission permission.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => AppSettings.openAppSettings(),
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }

  check() async {
    try {
      final String documentId = auth.currentUser!.uid.toString();

// Check if the document exists in the PendingWorkers collection
      final DocumentSnapshot pendingWorkersSnapshot = await FirebaseFirestore
          .instance
          .collection('Workers')
          .doc(documentId)
          .get();
      final DocumentSnapshot hirersSnapshot = await FirebaseFirestore.instance
          .collection('Hirers')
          .doc(documentId)
          .get();
      if (hirersSnapshot.exists) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/Home', ModalRoute.withName('/Home'));
      } else if (pendingWorkersSnapshot.exists) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/workerHome', ModalRoute.withName('/workerHome'));
      }

// Check if the document exists in the Hirers collection

      else if (pendingWorkersSnapshot.exists) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/Home', ModalRoute.withName('/Home'));
      } else {
        print("Else of landing page");
        auth.signOut();
        Navigator.pushNamedAndRemoveUntil(
            context, '/Role', ModalRoute.withName('/Role'));
      }
    } catch (e) {
      print("Inside check exceptionnnnnnnnnnnnnnnnnnnnnnnnn");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
