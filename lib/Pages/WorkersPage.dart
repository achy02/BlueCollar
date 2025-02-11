import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../Widgets/DisplayEmp.dart';
import '../Widgets/RangeSliderWithLabels.dart';

class WorkersPage extends StatefulWidget {
  WorkersPage({super.key, required this.category});
  final String category;

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  //Filters
  RangeValues _Age = RangeValues(18, 65);
  RangeValues Distance = RangeValues(0, 50);
  RangeValues ExpectedSalary = RangeValues(0, 100000);
  RangeValues Experience = RangeValues(0, 100000);
  String _gender = "";
  String _availability = "";
  //
  //bool filter
  bool _isAgefilter = false;
  bool _isExpanded = false;
  bool _xyz_ischecked = false;

  late final CollectionReference Workers = FirebaseFirestore.instance
      .collection('ApprovedWorkers')
      .doc(widget.category)
      .collection(widget.category);
  // final CollectionReference
// Methods to fetch
  late Stream<QuerySnapshot> workersStream;
//

  @override
  void initState() {
    super.initState();

    fetchWorkers();
  }

  Future<void> fetchWorkers() async {
    Query query = Workers;
    print("querying age");
    query = Workers.where('Age',
        isLessThan: _Age.end.toInt(), isGreaterThan: _Age.start.toInt());

    if (_gender == "male") {
      query = query.where('Gender', isEqualTo: 'Male');
      print("is male is true");
    }

    if (_gender == "other") {
      query = query.where('Gender', isEqualTo: 'Other');
      print("is male is true");
    }

    if (_gender == "female") {
      query = query.where('Gender', isEqualTo: 'Female');
    }

    if (_availability == "PartTime") {
      query = query.where('availability', isEqualTo: 'PT');
    }

    if (_availability == "FullTime") {
      query = query.where('availability', isEqualTo: 'FT');
    }

    setState(() {
      // call setState to update the widget with the new data
      workersStream = query.snapshots();
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
          bottomNavigationBar: Bottom_NavBar(indexx: 2),
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
              color: AppColors.ThemeBlue2,
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
            actions: <Widget>[
              SizedBox(
                child: Container(
                  margin: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  child: IconButton(
                    iconSize: 25,
                    // ignore: prefer_const_constructors
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                        print(_isExpanded);
                      });
                    },
                    icon: Icon(Icons.filter_list_outlined),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            /////////////
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            title: BigText(
              text: widget.category,
              ff: '',
              size: 40,
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
                    "/",
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
                                distcheck: Distance.end.toInt(),
                              ));
                            } else {
                              print("Has not Data");

                              return Center(child: CircularProgressIndicator());
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height:
                    _isExpanded ? MediaQuery.of(context).size.height * 0.50 : 0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          // First Slider
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  width: 85,
                                  height: _isExpanded ? 35 : 0,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: BigText(
                                    text: "Age:",
                                    size: 18,
                                    colorr: AppColors.font1,
                                    ff: '',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    height: _isExpanded ? 70 : 0,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    // ignore: prefer_const_constructors
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: _isExpanded
                                        ? Container(
                                            child: RangeSliderWithLabels(
                                              unit: "Yrs",
                                              start: _Age.start,
                                              end: _Age.end,
                                              min: 18,
                                              max: 65,
                                              onChanged: (value) {
                                                setState(() {
                                                  _Age = value;
                                                  _isAgefilter = true;
                                                  // workersStream = Workers.where(
                                                  //         'Age',
                                                  //         isLessThan: 26,
                                                  //         isGreaterThan: 24)
                                                  //     .snapshots();
                                                });
                                                print(_Age.start.toInt());
                                                print(_Age.end.toInt());
                                              },
                                            ),
                                          )
                                        : Container()),
                              ),
                            ],
                          ),
                          // ////////////////////////Second Slider/////////////////////////////
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  width: 88,
                                  height: _isExpanded ? 35 : 0,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: BigText(
                                    text: "Distance:",
                                    size: 18,
                                    colorr: AppColors.font1,
                                    ff: '',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    height: _isExpanded ? 70 : 0,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    // ignore: prefer_const_constructors
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: _isExpanded
                                        ? Container(
                                            child: RangeSliderWithLabels(
                                              unit: "KM",
                                              start: 0,
                                              end: Distance.end,
                                              min: 0,
                                              max: 100,
                                              onChanged: (value) {
                                                Distance = value;
                                                print("changing distance" +
                                                    Distance.toString());
                                              },
                                            ),
                                          )
                                        : Container()),
                              ),
                            ],
                          ),

//Third Slider

//Fourth Slider
                          // Row(
                          //   children: [
                          //     Container(
                          //       margin: EdgeInsets.only(bottom: 25),
                          //       alignment: Alignment.centerLeft,
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.only(top: 10, left: 10),
                          //         width: 85,
                          //         height: _isExpanded ? 35 : 0,
                          //         decoration: const BoxDecoration(
                          //           color: Colors.black,
                          //           borderRadius: BorderRadius.only(
                          //               topRight: Radius.circular(10),
                          //               bottomRight: Radius.circular(10)),
                          //         ),
                          //         child: BigText(
                          //           text: "Salary:",
                          //           size: 18,
                          //           colorr: AppColors.font1,
                          //           ff: '',
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //           height: _isExpanded ? 70 : 0,
                          //           margin: const EdgeInsets.only(
                          //               left: 10, right: 10),
                          //           width: MediaQuery.of(context).size.width,
                          //           // ignore: prefer_const_constructors
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: const BorderRadius.only(
                          //                   topRight: Radius.circular(10),
                          //                   bottomRight: Radius.circular(10),
                          //                   topLeft: Radius.circular(10),
                          //                   bottomLeft: Radius.circular(10))),
                          //           child: _isExpanded
                          //               ? Container(
                          //                   child: RangeSliderWithLabels(
                          //                     unit: "Rs/ per month)",
                          //                     start: 1000,
                          //                     end: 5000,
                          //                     min: 1000,
                          //                     max: 50000,
                          //                     onChanged: (value) {
                          //                       ExpectedSalary = value;

                          //                       print(ExpectedSalary.start
                          //                           .toInt());
                          //                       print(
                          //                           ExpectedSalary.end.toInt());
                          //                     },
                          //                   ),
                          //                 )
                          //               : Container()),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),

                      ///checkboxesss
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _isExpanded
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: AppColors.ThemeBluelight,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 25),
                                      child: BigText(
                                        text: "Customize:",
                                        ff: '',
                                        size: 18,
                                      ),
                                    ),
                                    BigText(
                                      text: "Gender:",
                                      ff: '',
                                      size: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10),
                                        Radio(
                                          value: 'male',
                                          groupValue: _gender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },
                                        ),
                                        BigText(
                                          text: "Male",
                                          ff: '',
                                          size: 18,
                                        ),
                                        SizedBox(width: 20),
                                        Radio(
                                          value: 'female',
                                          groupValue: _gender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },
                                        ),
                                        BigText(
                                          text: "Female",
                                          ff: '',
                                          size: 18,
                                        ),
                                        Radio(
                                          value: 'other',
                                          groupValue: _gender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },
                                        ),
                                        BigText(
                                          text: "Other",
                                          ff: '',
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'PartTime',
                                                groupValue: _availability,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _availability =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              BigText(
                                                text: "PartTime:",
                                                ff: '',
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 35),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'FullTime',
                                                groupValue: _availability,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _availability =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              BigText(
                                                text: "FullTime:",
                                                ff: '',
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 35, right: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print("Tapped on Apply");
                                setState(() {
                                  _isExpanded = false;
                                  print(_gender);
                                  // print(_Age.start.toInt());
                                  // print(_Age.end.toInt());
                                  // workersStream = Workers.where('Age',
                                  //         isLessThan: _Age.end.toInt(),
                                  //         isGreaterThan: _Age.start.toInt())
                                  //     .snapshots();
                                  fetchWorkers();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 20.0,
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              child: BigText(
                                text: "Apply",
                                ff: '',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("Tapped on Reset");
                                setState(() {
                                  _isExpanded = false;
                                  _gender = "";
                                  _availability = "";
                                  // print(_Age.start.toInt());
                                  // print(_Age.end.toInt());
                                  // workersStream = Workers.where('Age',
                                  //         isLessThan: _Age.end.toInt(),
                                  //         isGreaterThan: _Age.start.toInt())
                                  //     .snapshots();
                                  fetchWorkers();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 20.0,
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              child: BigText(
                                text: "Reset",
                                ff: '',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
