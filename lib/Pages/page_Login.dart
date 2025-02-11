import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/PhoneNumberTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class page_Login extends StatefulWidget {
  const page_Login({super.key});

  static String verifyId = "";
  @override
  State<page_Login> createState() => _page_LoginState();
}

// ignore: camel_case_types
class _page_LoginState extends State<page_Login> {
  TextEditingController countrycode = TextEditingController();
  var Phone = "";
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                BigText(text: "Login", size: 60, fw: FontWeight.bold),
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
                  height: 30,
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
                    FirebaseAuth auth = FirebaseAuth.instance;
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
                          page_Login.verifyId = verificationId;
                          print("Code Sent");
                          Navigator.pushNamed(context, "/OTP");
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
