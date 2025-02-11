import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/PhoneNumberTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pg_verifyLogin extends StatefulWidget {
  const pg_verifyLogin({super.key, required this.loginflag});

  final int loginflag;
  static String verifyId = "";
  @override
  State<pg_verifyLogin> createState() => pg_verifyLoginState();
}

// ignore: camel_case_types
class pg_verifyLoginState extends State<pg_verifyLogin> {
  TextEditingController countrycode = TextEditingController();
  var Phone = "";
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
    print(widget.loginflag);
  }

  @override
  Widget build(BuildContext context) {
    String text;
    if (widget.loginflag == 1) {
      text = "Login";
    } else {
      text = "Verify";
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        backgroundColor: AppColors.font1,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                BigText(text: "$text", size: 60, fw: FontWeight.bold),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                BigText(
                  text: " using OTP",
                  size: 20,
                  fw: FontWeight.bold,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/Images/Otp.jpeg',
                  width: 320,
                  height: 320,
                ),
                const SizedBox(
                  height: 50,
                ),
                // Row(children: [SizedBox(width: 40, child: TextField())]),
                PhoneNumberTextField(
                  text: "Hello",
                  tc: countrycode,
                  callback: (value) {
                    Phone = value;
                  },
                  phone: Phone,
                  callback2: () async {
                    // FirebaseAuth auth = FirebaseAuth.instance;
                    print("Sending" + countrycode.text + Phone);
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countrycode.text + Phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          print("Verification Complete");
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text("Error"),
                                    content: const Text("Verification Failed!"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          Navigator.pop(context);

                                          // print("Poped");
                                        },
                                        child: Container(
                                          color: Colors.lightBlue,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("okay",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          pg_verifyLogin.verifyId = verificationId;
                          print("Code Sent");
                          Navigator.pushNamed(context, "/Primary_OTP");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print("TimeOutttttttttttt");
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
