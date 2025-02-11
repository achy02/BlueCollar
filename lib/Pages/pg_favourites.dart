import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/DisplayEmp.dart';
import '../Widgets/RangeSliderWithLabels.dart';

class pg_favourites extends StatefulWidget {
  pg_favourites({
    super.key,
  });
  // final String category;

  @override
  State<pg_favourites> createState() => _pg_favouritesState();
}

class _pg_favouritesState extends State<pg_favourites> {
  //Filters

//
  final CollectionReference Workers = FirebaseFirestore.instance
      .collection('Hirers')
      .doc(page_LandingState.auth.currentUser?.uid)
      .collection("Favourites");
// Methods to fetch
  late Stream<QuerySnapshot> workersStream;
//
  @override
  void initState() {
    super.initState();
    fetchWorkers();
  }

  Future<void> fetchWorkers() async {
    setState(() {
      // call setState to update the widget with the new data
      workersStream = Workers.snapshots();
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
          bottomNavigationBar: Bottom_NavBar(indexx: 1),
          appBar: AppBar(
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
              // gradient: LinearGradient(
              //     colors: [
              //       Color(0xFF3366FF),
              //       Color(0xFF00CCFF),
              //     ],
              //     begin: FractionalOffset(0.0, 0.0),
              //     end: FractionalOffset(1.0, 0.0),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp),
            )),
            //Right corner filter button
            actions: <Widget>[],
            /////////////
            backgroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            title: BigText(
              text: "Favourites",
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
                    "/Home",
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
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height - 220,
                        child: StreamBuilder(
                          // stream: Workers.snapshots(),
                          stream: workersStream,
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            print(streamSnapshot.toString());
                            print(streamSnapshot.hasData.toString() +
                                " BOOLEANS");
                            if (streamSnapshot.hasData) {
                              print("Has Data");
                              return Container(
                                  child: DisplayEMP(
                                      streamSnapshot: streamSnapshot,
                                      fav: true));
                            } else {
                              print("Has not Data");

                              return const Scaffold(
                                  body: Center(
                                      child: CircularProgressIndicator()));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // Bottom_NavBar(indexx: 2),
                  // const Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   bottom: 0,
                  //   child: Bottom_NavBar(
                  //     indexx: 2,
                  //   ),
                  // ),
                ],
              ),
              ///////////////////////////////////FILTERSSSSSSSSSSSSSSSS///////////////////
            ],
          )),
    );
  }
}
