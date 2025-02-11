import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bluecollar/Widgets/ProfilePicture.dart';
import 'package:flutter/services.dart';

import '../Widgets/Bottom_NavBar_Worker.dart';

class editprofileworker extends StatefulWidget {
  const editprofileworker({super.key});
  @override
  State<editprofileworker> createState() => _editprofileworkerState();
}

class _editprofileworkerState extends State<editprofileworker> {
  late var documentData;
  String text = "";
  String newtext = "";
  String age = "";
  String phone = "";
  String Aadhaar = "";
  String _phonenumber = "Phone_Number";
  String _adharnumber = "Adhar_Number";
  String _jobcategory = "Job Category";
  String _experience = "Job experience";
  String _bio = "Bio";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseFirestore.instance
    //     .collection('PendingWorkers')
    //     .doc(page_LandingState.auth.currentUser?.uid.toString())
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     setState(() {
    //       documentData = documentSnapshot.data();
    //       print("Setting state" + documentData['Name']);
    //       text = documentData['Name'];
    //       age = documentData['Age'].toString();
    //     });
    //   } else {
    //     print("doesnt exist");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                page_LandingState.auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
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
          text: "Blue-Collar",
          fw: FontWeight.bold,
          colorr: Colors.white,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      bottomNavigationBar: Bottom_NavBar_Worker(indexx: 2),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Workers')
            .doc(page_LandingState.auth.currentUser?.uid.toString())
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('No data found'),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String name = data['Name'] ?? '';
          int age = data['Age'] ?? 0;
          String address = data['Address'] ?? '';
          String phone = data['Phone'] ?? '';
          String Aadhaar = data['Aadhar_Number'] ?? '';
          String Bio = data['Bio'] ?? '';
          String Experience = data['Experience'] ?? '';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
              ),
              child: Column(
                children: [
                  Center(
                    child: BigText(
                      text: "Your Details ",
                      fw: FontWeight.bold,
                      size: 25,
                    ),
                  ),
                  //text control
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ProfilePicture(
                      callbackVerifyimageUpload: () {},
                      size: 50.0,
                      editable: true,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: false,
                            maxLength: 20,
                            decoration: InputDecoration(
                                // labelText: ,
                                ),
                            initialValue: name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                newtext = value;
                              });
                            },
                          ),
                          TextFormField(
                            enabled: false,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                // labelText: age,

                                ),
                            initialValue: age.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              int? age = int.tryParse(value);
                              if (age == null || age < 1) {
                                return 'Please enter a valid age';
                              }
                              if (age < 18) {
                                return "You are not allowed as an underage";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                newtext = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              enabled: false,
                              decoration: const InputDecoration(
                                  // labelText: 'Address',
                                  ),
                              initialValue: address,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  newtext = value;
                                });
                              },
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            maxLength: 13,
                            decoration:
                                InputDecoration(labelText: _phonenumber),
                            initialValue: phone,
                          ),
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(labelText: _experience),
                            initialValue: Experience,
                          ),
                          TextFormField(
                            enabled: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: _bio,
                            ),
                            initialValue: Bio,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 15),
                    child: BigButton(
                      text: "Edit Details",
                      size: 18,
                      callback: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text("Waring!"),
                                  content: const Text(
                                      "Are you sure you want to edit details?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "/Register_Worker",
                                            (route) => false);
                                      },
                                      child: Container(
                                        color: Colors.lightBlue,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      width: 0.50,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//     return Scaffold(
//       body: 
//     
// }
