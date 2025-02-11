import 'dart:ffi';

import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:bluecollar/Widgets/CurrentStatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Widgets/DisplayEmp.dart';

class Requested extends StatefulWidget {
  Requested({
    super.key,
  });
  // final String category;

  @override
  State<Requested> createState() => RequestedState();
}

class RequestedState extends State<Requested> {
  //Filters
  bool is_accepted = false;
  bool is_pending = true;
  bool is_rejected = false;
  final CollectionReference Workers = FirebaseFirestore.instance
      .collection('Hirers')
      .doc(page_LandingState.auth.currentUser?.uid)
      .collection("Requested");
// Methods to fetch
  late Stream<QuerySnapshot> workersStream;

  Stream<QuerySnapshot> fetchreq(int fetch) {
    print("Fetechingggggggggg");
    switch (fetch) {
      case 2:

        // DocumentReference ds =
        final Query acceptedWorkersQuery =
            Workers.where('status', isEqualTo: 'Rejected');
        //     Workers.doc(page_LandingState.auth.currentUser?.uid.toString());.
        print(Workers.snapshots().length);
        return acceptedWorkersQuery.snapshots();

        break;
      case 1:

        // DocumentReference ds =
        final Query acceptedWorkersQuery =
            Workers.where('status', isEqualTo: 'Accepted');
        //     Workers.doc(page_LandingState.auth.currentUser?.uid.toString());.
        print(Workers.snapshots().length);
        return acceptedWorkersQuery.snapshots();

        break;
      default:

        // DocumentReference ds =
        final Query acceptedWorkersQuery =
            Workers.where('status', isEqualTo: 'Pending');
        //     Workers.doc(page_LandingState.auth.currentUser?.uid.toString());.
        print(Workers.snapshots().length);
        // return acceptedWorkersQuery.snapshots();
        print("Returning the pendng");
        return acceptedWorkersQuery.snapshots();

        break;
    }
  }

//
  @override
  void initState() {
    super.initState();
    if (is_accepted == true) {
      workersStream = fetchreq(1);
      print("fetching accepted");
    } else if (is_pending == true) {
      workersStream = fetchreq(0);
      print("feteching pending");
    }
    if (is_rejected == true) {
      workersStream = fetchreq(2);
      print("fetching rejected");
    }
  }

  // print('Size of document is :' + querySnapshot.size.toString());
  // for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //   print('${documentSnapshot.id} => ${documentSnapshot.data()}');
  // }

  @override
  Widget build(BuildContext context) {
    if (is_pending == true) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 75,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Pending",
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            print("clicked on pending");
                            workersStream = fetchreq(0);
                            is_pending = true;
                            is_rejected = false;
                            is_accepted = false;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Accepted",
                        size: 15,
                        width: 0.29,
                        right: 0,
                        clr: Colors.transparent,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(1);
                            is_pending = false;
                            is_rejected = false;
                            is_accepted = true;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Rejected",
                        clr: Colors.transparent,
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(2);
                            is_pending = false;
                            is_rejected = true;
                            is_accepted = false;
                          });
                        }),
                  ),
                  // BigButton(text: "Approved", size: 0.1, callback: () {}),
                  // BigButton(text: "Rejected", size: 0.1, callback: () {}),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.ThemeBluelight,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: StreamBuilder(
                  // stream: Workers.snapshots(),
                  stream: workersStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      print("inside pending is trueee");
                      List<QueryDocumentSnapshot> data =
                          streamSnapshot.data!.docs;
                      print("Has Data in requested" +
                          data.length.toString() +
                          toString());

                      if (data.length > 0) {
                        print("inside pending is true has more than 1");

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String id = data[index].id;
                            String Name = data[index].get('Name');
                            String status = data[index].get('status');
                            String imgurl = data[index].get('img');
                            // String Phone = data[index].get('Phone');
                            // print("data is " + data[index].data().toString());

                            print(imgurl);
                            return CurrentStatus(
                              username: Name,
                              status: status,
                              imgUrl: imgurl,
                              role: 1,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: BigText(
                                text: "You have not received any requests"));
                      }
                    } else {
                      print("Has not Data");

                      return Center(
                          child: BigText(
                              text: "You have not received any requests"));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (is_accepted == true) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 75,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Pending",
                        clr: Colors.transparent,
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(0);
                            is_pending = true;
                            is_rejected = false;
                            is_accepted = false;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Accepted",
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(1);
                            is_pending = false;
                            is_rejected = false;
                            is_accepted = true;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Rejected",
                        clr: Colors.transparent,
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(2);
                            is_pending = false;
                            is_rejected = true;
                            is_accepted = false;
                          });
                        }),
                  ),
                  // BigButton(text: "Approved", size: 0.1, callback: () {}),
                  // BigButton(text: "Rejected", size: 0.1, callback: () {}),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.ThemeBluelight,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: StreamBuilder(
                  // stream: Workers.snapshots(),
                  stream: workersStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      List<QueryDocumentSnapshot> data =
                          streamSnapshot.data!.docs;
                      print("Has Data in requested" +
                          data.length.toString() +
                          toString());

                      if (data.length > 0) {
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String id = data[index].id;
                            String Name = data[index].get('Name');
                            String status = data[index].get('Desc');
                            String imgurl = data[index].get('img');
                            print("data is " + data[index].data().toString());
                            String Phone = data[index].get('Phone:');
                            String rolee = data[index].get('role');
                            bool isRated = data[index].get('isRated');

                            return CurrentStatus(
                              username: Name,
                              status: status,
                              imgUrl: imgurl,
                              Phone: Phone,
                              role: 2,
                              workerrole: rolee,
                              hid: page_LandingState.auth.currentUser!.uid,
                              wid: id,
                              isRated: isRated,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: BigText(
                                text: "You have not received any requests"));
                      }
                    } else {
                      print("Has not Data");

                      return Center(
                          child: BigText(
                              text: "You have not received any requests"));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (is_rejected == true) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 75,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Pending",
                        clr: Colors.transparent,
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(0);
                            is_pending = true;
                            is_rejected = false;
                            is_accepted = false;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Accepted",
                        clr: Colors.transparent,
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(1);
                            is_pending = false;
                            is_rejected = false;
                            is_accepted = true;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: BigButton(
                        text: "Rejected",
                        size: 15,
                        width: 0.29,
                        right: 0,
                        left: 9,
                        callback: () {
                          setState(() {
                            workersStream = fetchreq(2);
                            is_pending = false;
                            is_rejected = true;
                            is_accepted = false;
                          });
                        }),
                  ),
                  // BigButton(text: "Approved", size: 0.1, callback: () {}),
                  // BigButton(text: "Rejected", size: 0.1, callback: () {}),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.ThemeBluelight,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: StreamBuilder(
                  // stream: Workers.snapshots(),
                  stream: workersStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      print("inside rejected is true");
                      List<QueryDocumentSnapshot> data =
                          streamSnapshot.data!.docs;
                      print("Has Data in requested" +
                          data.length.toString() +
                          toString());

                      if (data.length > 0) {
                        print("inside pending is true has more than 1");

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String id = data[index].id;
                            String Name = data[index].get('Name');
                            String status = data[index].get('status');
                            String imgurl = data[index].get('img');
                            print(imgurl);
                            return CurrentStatus(
                              username: Name,
                              status: status,
                              imgUrl: imgurl,
                              role: 3,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: BigText(
                                text: "You have not received any requests"));
                      }
                    } else {
                      print("Has not Data");

                      return Center(
                          child: BigText(
                              text: "You have not received any requests"));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }

    // Bottom_NavBar(indexx: 2),
    // const Positioned(
    //   left: 0,
    //   right: 0,
    //   bottom: 0,
    //   child: Bottom_NavBar(
    //     indexx: 2,
    //   ),
    // ),
  }
}
