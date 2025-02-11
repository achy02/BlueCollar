import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Pages/page_workerinfo.dart';
import 'package:bluecollar/Pages/worker_homepage.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar_Worker.dart';
import 'package:bluecollar/Widgets/CurrentStatus.dart';
import 'package:bluecollar/Widgets/RequestWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//////////////////////////// move requests to Workers from Approved workers

import '../Widgets/DisplayEmp.dart';

class displayreq_workers extends StatefulWidget {
  final String role;
  displayreq_workers({
    super.key,
    required this.role,
  });
  // final String category;

  @override
  State<displayreq_workers> createState() => displayreq_workersState();
}

class displayreq_workersState extends State<displayreq_workers> {
  //Filters
  late Stream<QuerySnapshot> workersStream;
  bool is_accepted = false;
  bool is_pending = true;
  bool is_rejected = false;
//check in approved workers if data is getting fetched or not
  Stream<QuerySnapshot> fetchreq(int fetch) {
    print("Fetechingggggggggg");
    switch (fetch) {
      case 2:
        print(widget.role + "is widget role");
        final CollectionReference Workers = FirebaseFirestore.instance
            .collection('ApprovedWorkers')
            .doc(widget.role)
            .collection(widget.role)
            .doc(page_LandingState.auth.currentUser?.uid.toString())
            .collection('Requests');
        // DocumentReference ds =
        final Query acceptedWorkersQuery =
            Workers.where('status', isEqualTo: 'Rejected');
        //     Workers.doc(page_LandingState.auth.currentUser?.uid.toString());.
        print(Workers.snapshots().length);
        return acceptedWorkersQuery.snapshots();

        break;
      case 1:
        print(widget.role + "is widget role");
        final CollectionReference Workers = FirebaseFirestore.instance
            .collection('ApprovedWorkers')
            .doc(widget.role)
            .collection(widget.role)
            .doc(page_LandingState.auth.currentUser?.uid.toString())
            .collection('Requests');
        // DocumentReference ds =
        final Query acceptedWorkersQuery =
            Workers.where('status', isEqualTo: 'Accepted');
        //     Workers.doc(page_LandingState.auth.currentUser?.uid.toString());.
        print(Workers.snapshots().length);
        return acceptedWorkersQuery.snapshots();

        break;
      default:
        print("default is executed");
        final CollectionReference Workers = FirebaseFirestore.instance
            .collection('ApprovedWorkers')
            .doc(widget.role)
            .collection(widget.role)
            .doc(page_LandingState.auth.currentUser?.uid.toString())
            .collection('Requests');
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

// Methods to fetch
  // DocumentReference user = FirebaseFirestore.instance
  //     .collection('Workers')
  //     .doc(page_LandingState.auth.currentUser?.uid);
//
  @override
  void initState() {
    super.initState();
    print("inside inittttttttttttt_--------------------------");
    if (is_accepted == true) {
      workersStream = fetchreq(1);
    } else if (is_pending == true) {
      workersStream = fetchreq(0);
    }
    if (is_rejected == true) {
      workersStream = fetchreq(2);
    }
  }

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
                      List<QueryDocumentSnapshot> data =
                          streamSnapshot.data!.docs;

                      if (data.length > 0) {
                        print("inside pending is true has more than 1");

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String id = data[index].id;
                            String Name = data[index].get('Name');
                            String status = data[index].get('Desc');
                            String address = data[index].get('Address');
                            String imgurl = data[index].get('img');
                            print(imgurl);
                            return RequestWidget(
                              name: Name,
                              message: status,
                              imageUrl: imgurl,
                              address: address,
                              onAccept: () {
                                if (worker_homepage.workerinfo != null) {
                                  FirebaseOperations.Requestaccept(
                                      page_LandingState.auth.currentUser!.uid,
                                      data[index].id.toString(),
                                      worker_homepage.workerinfo['Role'],
                                      true);
                                  print("accepted" + Name + id);
                                }
                              },
                              onReject: () {
                                FirebaseOperations.Requestaccept(
                                    page_LandingState.auth.currentUser!.uid,
                                    data[index].id.toString(),
                                    worker_homepage.workerinfo['Role'],
                                    false);
                              },
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
                          child: BigText(text: "You have do not any requests"));
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
                      print("inside pending is true");
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
                            String status = data[index].get('Desc');
                            String imgurl = data[index].get('img');
                            print(imgurl);
                            return RequestWidget(
                              name: Name,
                              state: 1,
                              message: status,
                              imageUrl: imgurl,
                              onAccept: () {
                                if (worker_homepage.workerinfo != null) {
                                  FirebaseOperations.Requestaccept(
                                      page_LandingState.auth.currentUser!.uid,
                                      data[index].id.toString(),
                                      worker_homepage.workerinfo['Role'],
                                      true);
                                  print("accepted" + Name + id);
                                }
                              },
                              onReject: () {},
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: BigText(
                                text: "You have not accepted any requests"));
                      }
                    } else {
                      print("Has not Data");

                      return Center(
                          child: BigText(
                              text: "You have not accepted any requests"));
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
                      print("inside pending is true");
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
                            String status = data[index].get('Desc');
                            String imgurl = data[index].get('img');
                            print(imgurl);
                            return RequestWidget(
                              name: Name,
                              message: status,
                              state: 2,
                              imageUrl: imgurl,
                              onAccept: () {
                                if (worker_homepage.workerinfo != null) {
                                  FirebaseOperations.Requestaccept(
                                      page_LandingState.auth.currentUser!.uid,
                                      data[index].id.toString(),
                                      worker_homepage.workerinfo['Role'],
                                      true);
                                  print("accepted" + Name + id);
                                }
                              },
                              onReject: () {},
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: BigText(
                                text: "You have not rejected any requests"));
                      }
                    } else {
                      print("Has not Data");

                      return Center(
                          child: BigText(
                              text: "You have not rejected any requests"));
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
