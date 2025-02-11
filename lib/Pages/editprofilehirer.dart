import 'package:bluecollar/Pages/HomeScreen.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/userImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:flutter/material.dart';
import 'package:bluecollar/Widgets/ProfilePicture.dart';

import '../Widgets/BigButton.dart';

class editprofilehirer extends StatefulWidget {
  const editprofilehirer({
    super.key,
  });
  @override
  State<editprofilehirer> createState() => _editprofilehirerState();
}

class _editprofilehirerState extends State<editprofilehirer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nameUser = HomeScreen.userData['Name'];
  String ageUser = HomeScreen.userData['Age'].toString();
  String addressUser = HomeScreen.userData['Address'].toString();
  String Useremail = HomeScreen.userData['Email'].toString();
  String Userphonenumber = HomeScreen.userData['Phone'].toString();
  String Useradharnumber = HomeScreen.userData['Aadhar_Number'].toString();

  @override
  Widget build(BuildContext context) {
    print("calling build again");

    print(nameUser +
        ageUser +
        addressUser +
        Useremail +
        Userphonenumber +
        Useradharnumber);

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
                const PopupMenuItem(
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
      bottomNavigationBar: Bottom_NavBar(indexx: 4),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          children: [
            Center(
              child: BigText(
                text: "Edit Profile",
                fw: FontWeight.bold,
                size: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45.0),
              child: ProfilePicture(
                callbackVerifyimageUpload: () {},
                size: 50.0,
                editable: true,
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: "$nameUser",
                            maxLength: 20,
                            decoration: InputDecoration(),
                            onSaved: (newValue) {
                              nameUser = newValue.toString();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                nameUser = value;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: "$ageUser",
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(),
                            onSaved: (newValue) {
                              ageUser = newValue.toString();
                            },
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
                                ageUser = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              initialValue: "$addressUser",
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Address",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  addressUser = value;
                                });
                              },
                            ),
                          ),
                          TextFormField(
                            maxLength: 20,
                            keyboardType: TextInputType.emailAddress,
                            initialValue: "$Useremail",
                            decoration: InputDecoration(),
                            onSaved: (newValue) {
                              print("saving $Useremail");
                              Useremail = newValue.toString();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              final regex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!regex.hasMatch(value)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                              enabled: false,
                              maxLength: 10,
                              initialValue: "$Userphonenumber"),
                          TextFormField(
                              enabled: false,
                              maxLength: 12,
                              initialValue: "$Useradharnumber"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      {
                        if (_formKey.currentState?.validate() ?? true) {
                          _formKey.currentState?.save();
                          print(
                              "Saved now new name = $nameUser,$nameUser,$ageUser,$addressUser,$Useremail");
                          // Call the updateHirerData function with the new values
                          FirebaseOperations.updateHirerData(
                            page_LandingState.auth.currentUser!.uid.toString(),
                            nameUser,
                            ageUser,
                            addressUser,
                            Useremail,
                          );

                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Congratulations!"),
                              content: const Text(
                                  "Your data has been updated successfully"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    Navigator.pushNamed(
                                      context,
                                      "/Home",
                                    );
                                  },
                                  child: Container(
                                    color: Colors.lightBlue,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text(
                                      "Okay",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
