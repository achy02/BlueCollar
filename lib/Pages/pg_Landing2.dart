import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Pages/page_Role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class page_Landing2 extends StatefulWidget {
  const page_Landing2({
    super.key,
  });
  @override
  page_LandingState2 createState() => page_LandingState2();
}

class page_LandingState2 extends State<page_Landing2> {
  bool _username = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // String? currentUser = page_LandingState.auth.currentUser?.uid.toString();
    // String? currentUser = page_LandingState.auth.currentUser?.uid.toString();
    String? currentUser = auth.currentUser?.uid.toString();
    Future.delayed(Duration.zero, () {
      // print(_loadUserInfo());
      if (page_LandingState.auth.currentUser != null) {
        print("Sign in");
        if (page_Role.role) {
          print("checking hirer");
          checkHirer(currentUser!);
        } else {
          print("checking worker");

          checkworker(currentUser!);
        }
      } else {
        print("not Sign in");
      }
    });
  }

  // _loadUserInfo() async {
  //   if (_username == true) {
  //     print("username is null");
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, '/Login', ModalRoute.withName('/Login'));
  //   } else {
  //     print("Logged in successfully");
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, '/Register_Hirer', ModalRoute.withName('/Register_Hirer'));
  //   }
  // }

  checkHirer(String uid) {
    print("Checking $uid");
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('Hirers');
    final DocumentReference myDocument = myCollection.doc(uid);
    myDocument.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(
          "Existss",
        );
        Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
        // document exists, you can access its data using documentSnapshot.data()
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "/Register_Hirer", (route) => false);

        // document does not exist
      }
    });
  }

  checkworker(String uid) {
    final CollectionReference worker =
        FirebaseFirestore.instance.collection('Workers');

    final DocumentReference myDocument = worker.doc(uid);
    myDocument.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        print(data['Name']);
        Navigator.pushNamedAndRemoveUntil(
            context, "/workerHome", (route) => false);
        // document exists, you can access its data using documentSnapshot.data()
      } else {
        print("Worker nahi hai" + uid + "000000000\n");
        Navigator.pushNamedAndRemoveUntil(
            context, "/Register_Worker", (route) => false);

        // // document does not exist
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
