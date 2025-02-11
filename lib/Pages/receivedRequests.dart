import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar_Worker.dart';
import 'package:bluecollar/Widgets/CurrentStatus.dart';
import 'package:bluecollar/Widgets/displayreq_workers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Widgets/DisplayEmp.dart';

class receivedRequests extends StatefulWidget {
  receivedRequests({
    super.key,
  });
  // final String category;

  @override
  State<receivedRequests> createState() => receivedRequestsState();
}

class receivedRequestsState extends State<receivedRequests> {
  //Filters

//
  String roleF = "";
  bool r = false;

// Methods to fetch
  DocumentReference user = FirebaseFirestore.instance
      .collection('Workers')
      .doc(page_LandingState.auth.currentUser?.uid);
  var data;
  @override
  void initState() {
    super.initState();
    if (roleF == "") {
      user.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            var role = data['Role'];
            print('The role of the document is: $role');
            setState(() {
              roleF = role;
              r = true;
            });
          } else {
            print('Document data is null');
          }
        } else {
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Error getting document: $error');
      });
    }
  }

  Future<void> fetchWorkers() async {
    final CollectionReference Workers = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(page_LandingState.auth.currentUser?.uid)
        .collection("Requestedd");
    setState(() {
      // call setState to update the widget with the new data
    });
    // QuerySnapshot querySnapshot = await query.get();
    // print('Size of document is :' + querySnapshot.size.toString());
    // for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    //   print('${documentSnapshot.id} => ${documentSnapshot.data()}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: Scaffold(
          bottomNavigationBar: Bottom_NavBar_Worker(indexx: 1),
          appBar: AppBar(
            //Right corner filter button
            actions: <Widget>[],
            /////////////
            backgroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            flexibleSpace: Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            )),
            title: BigText(
              text: "Received Requests",
              ff: '',
              size: 22,
              fw: FontWeight.bold,
              colorr: AppColors.font1,
            ),
            leading: SizedBox(
              child: IconButton(
                iconSize: 25,
                // ignore: prefer_const_constructors
                onPressed: () {
                  print("Pressed");
                  Navigator.pushNamed(
                    context,
                    "/workerHome",
                  );
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
              ),
            ),
          ),
          ///////////////////////////Body
          body: Stack(
            children: [
              Column(
                children: [
                  // Container(

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height - 220,
                        child: r ? displayreq_workers(role: roleF) : null,
                      ),
                    ),
                  ),
                ],
              ),
              ///////////////////////////////////FILTERSSSSSSSSSSSSSSSS///////////////////
            ],
          )),
    );
  }
}
