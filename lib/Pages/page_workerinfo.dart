import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';

import '../Utils/AppColors.dart';
import '../Widgets/BigButton.dart';

class page_workerinfo extends StatefulWidget {
  // final String name;
  // final String Age,gender,Bio,Experience,Salary;
  // final String;
  final bool favs;
  final DocumentSnapshot ds;
  bool requested = false;

  page_workerinfo({
    super.key,
    required this.ds,
    this.favs = false,
  });

  @override
  State<page_workerinfo> createState() => _page_workerinfoState();
}

class _page_workerinfoState extends State<page_workerinfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in worker inittttttttt");
    checkrequeststatus();
  }

  Future<List<String>> checkrequeststatus() async {
    print("Checkintggggggggggggggggggggggggggggggg");
    CollectionReference DBworker = FirebaseFirestore.instance
        .collection('ApprovedWorkers')
        .doc(widget.ds['Role'])
        .collection(widget.ds['Role'])
        .doc(widget.ds.id.toString())
        .collection("Requests");
    final QuerySnapshot querySnapshot = await DBworker.get();
    final List<DocumentSnapshot> docs = querySnapshot.docs;
    final List<String> ids = docs.map((doc) => doc.id).toList();
    print(ids);
    return ids;
    // if (ids.contains(
    //   page_LandingState.auth.currentUser?.uid,
    // )) {
    //   setState(() {
    //     widget.requested = true;
    //   });
    // }
    ;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.ds.data() as Map<String, dynamic>;
    String rating = "0.0", numberratings = "0";
    if (data.containsKey('rating')) {
      // The field exists in the document
      rating = data['rating'].toStringAsFixed(1);
      numberratings = data['ratings'].toStringAsFixed(0);
      if (data['ratings'] > 1000) {
        numberratings = (data["ratings"] / 1000).toString() + "K";
      }
    }

    TextEditingController tc = TextEditingController();

    tc.text = " ";

    TextFieldWidget5(String title, IconData iconData, String value,
        {bool readOnly = true}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffA7A7A7)),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // width: 20,
              // height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                readOnly: readOnly,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Icon(iconData, color: Colors.blue),
                  ),
                  border: InputBorder.none,
                ),
                initialValue: value,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      );
    }

    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.height * 0.87);
    return FutureBuilder<List<String>>(
        future: checkrequeststatus(),
        builder: (context, snapshot) {
          print("Snapshot.data:" + snapshot.data.toString());
          bool futrequested = false;
          List<String>? ids = snapshot.data;
          if (ids != null) {
            if (ids.contains(
              page_LandingState.auth.currentUser?.uid,
            )) {
              print("ALREADYYY REQUESTEDD");
              futrequested = true;
            } else {
              print("NOT REQUESTED");
              futrequested = false;
            }
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  centerTitle: true,
                  title: BigText(
                    text: 'Bluecollar',
                    colorr: Colors.white,
                    fw: FontWeight.bold,
                    size: 30,
                  ),
                  elevation: 0.0,
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
                  ))),
              //removed singlechild scroll
              body: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, top: 45),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[400],
                                size: 55,
                              ),
                              BigText(
                                text: "$rating",
                                ff: "",
                                size: 35,
                                colorr: AppColors.font1,
                                fw: FontWeight.bold,
                              ),
                              BigText(
                                text: "($numberratings)",
                                size: 15,
                                ff: "",
                                colorr: AppColors.font1,
                                fw: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 115),
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 45, right: 38),
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 77,
                              child: CircleAvatar(
                                backgroundColor: AppColors.purpleligher,
                                radius: 77,
                                // child: InkWell(
                                //   splashColor: Colors.transparent,
                                //   highlightColor: Colors.transparent,
                                //   child: AppRoundImage.url(img, width: 80, height: 80),
                                // ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.ds['img'],
                                    width: 147,
                                    height: 147,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.80,
                        color: Colors.white,
                        child: Column(

                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            ////////////////////////////////////////////////////////////////////////////////////////////////
                            children: [
                              TextFieldWidget5('Name', Icons.person_outlined,
                                  widget.ds['Name']),

                              TextFieldWidget5('Age', Icons.calendar_today,
                                  widget.ds['Age'].toString()),

                              if (widget.ds['Gender'] == "Male")
                                TextFieldWidget5(
                                    'Gender', Icons.male, widget.ds['Gender']),

                              if (widget.ds['Gender'] == "Female")
                                TextFieldWidget5('Gender', Icons.female,
                                    widget.ds['Gender']),

                              if (widget.ds['Gender'] == "Other")
                                TextFieldWidget5('Gender', Icons.transgender,
                                    widget.ds['Gender']),

                              TextFieldWidget5(
                                  'Expected Salary',
                                  Icons.attach_money,
                                  widget.ds['Expected_Salary']),

                              TextFieldWidget5(
                                  'About', Icons.description, widget.ds['Bio']),
                              TextFieldWidget5('Experience', Icons.description,
                                  widget.ds['Experience']),

                              // TextField(
                              //   // controller: ,
                              //   enabled: false,
                              //   controller: tc,
                              //   keyboardType: TextInputType.multiline,
                              //   maxLines: 4,

                              //   style: TextStyle(
                              //       fontFamily: 'Playfair',
                              //       color: Colors.blueGrey,
                              //       fontSize: 20),

                              //   decoration: InputDecoration(
                              //       disabledBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               width: 1,
                              //               color: Color.fromARGB(255, 0, 0, 0)))),
                              // ),

                              SizedBox(
                                height: 27.5,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    child: widget.favs
                        ? Container(
                            width: double.infinity,
                            // alignment: Alignment.center,

                            child: Container(
                              color: Colors.white,
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: futrequested || widget.requested
                                    ? ElevatedButton(
                                        onPressed: () {
                                          // FirebaseOperations.addRequests(
                                          //     page_LandingState.auth.currentUser?.uid,
                                          //     widget.ds);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey),
                                        child: BigText(
                                          text: "Request Sent",
                                          colorr: Colors.white,
                                        ))
                                    : ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                String userInput = '';
                                                return AlertDialog(
                                                  title:
                                                      Text('Job Description'),
                                                  content: TextField(
                                                    onChanged: (value) {
                                                      userInput = value;
                                                    },
                                                    maxLines: 5,
                                                    maxLength:
                                                        100, // Allow multiline input
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Enter text here',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        print(
                                                            'User input: $userInput');

                                                        // print("Sending");
                                                        FirebaseOperations
                                                            .addRequests(
                                                                page_LandingState
                                                                    .auth
                                                                    .currentUser
                                                                    ?.uid,
                                                                widget.ds,
                                                                userInput);
                                                        setState(() {
                                                          widget.requested =
                                                              true;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Send'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: BigText(
                                          text: "Send Request",
                                          colorr: Colors.white,
                                        )),
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 20),
                                  child: futrequested || widget.requested
                                      ? ElevatedButton(
                                          onPressed: () {
                                            // FirebaseOperations.addRequests(
                                            //     page_LandingState.auth.currentUser?.uid,
                                            //     widget.ds);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey),
                                          child: BigText(
                                            text: "Request Sent",
                                            colorr: Colors.white,
                                          ))
                                      : ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  String userInput = '';
                                                  return AlertDialog(
                                                    title:
                                                        Text('Job Description'),
                                                    content: TextField(
                                                      onChanged: (value) {
                                                        userInput = value;
                                                      },
                                                      maxLines: 5,
                                                      maxLength:
                                                          100, // Allow multiline input
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Enter text here',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          print(
                                                              'User input: $userInput');

                                                          // print("Sending");
                                                          FirebaseOperations
                                                              .addRequests(
                                                                  page_LandingState
                                                                      .auth
                                                                      .currentUser
                                                                      ?.uid,
                                                                  widget.ds,
                                                                  userInput);
                                                          setState(() {
                                                            widget.requested =
                                                                true;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Send'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: BigText(
                                            text: "Send Request",
                                            colorr: Colors.white,
                                          )),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  padding: EdgeInsets.only(
                                      right: 10, top: 10, bottom: 20),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        FirebaseOperations.addFavourites(
                                            page_LandingState
                                                .auth.currentUser?.uid,
                                            widget.ds);

                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  title: const Text(
                                                      "Contact Details"),
                                                  // content: const Text(
                                                  //     "Phone number: xxxxxxxxxxxxx"),
                                                  content: BigText(
                                                      text:
                                                          "Added to favorite"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Container(
                                                        color: Colors.lightBlue,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: const Text(
                                                            "okay",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: BigText(
                                        text: "Add To Favourite",
                                        colorr: Colors.white,
                                        size: 18,
                                      )),
                                ),
                              ],
                            ),
                          ),
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   alignment: Alignment.bottomCenter,
                  //   width: double.infinity,
                  //   padding: EdgeInsets.only(bottom: 15),
                  //   child: BigButton(
                  //     text: "Update",
                  //     size: 18,
                  //     callback: () {},
                  //     width: 0.50,
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }
}
