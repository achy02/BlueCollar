import 'dart:async';

import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_signin_button/flutter_signin_button.dart';

signinInwithGoogle(BuildContext context) async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userInfo =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userInfo.user != null) {
      // Sign-in successful
      print("Signin Successful");
      print(userInfo.user!.displayName);
      // Showing Dialog of Sigin Succesful
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                    'Welcome, ' + userInfo.user!.displayName.toString() + "!"),
                content: const Text("Let's Get your Phone Number Verified!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      // print("Poped");
                      if (true) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/Primary_Login",
                          (route) => false,
                        );
                      }
                    },
                    child: Container(
                      color: Colors.lightBlue,
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ));
      // Showing Dialog of Sigin Succesful/

//
      ///if new user

//if old user//
//
    } else {
      // Sign-in failed
      print('Sign-in failed');
    }
  } catch (e) {
    // Error occurred
    print('Error occurred while signing in: $e');
  }
}

class SignUp extends StatelessWidget {
  static String signup_verifyID = "";
  static bool signupfields = false;
  final _formKey = GlobalKey<FormState>();

  static String tname = "";
  static String tphone = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ignore: prefer_const_constructors
              SizedBox(
                height: 80,
              ),
              BigText(
                text: "Hello There!",
                size: 40,
                fw: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                  child: BigText(
                text: "Let's get started.",
                size: 20,
                fw: FontWeight.bold,
              )),
              const SizedBox(
                height: 25,
              ),
              SignInButtonBuilder(
                width: MediaQuery.of(context).size.width * 0.80,
                // ignore: prefer_const_constructors
                // image: Image.asset(
                //   'assets/logos/google_light.png',
                //   package: 'flutter_signin_button',
                // ),
                image: Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    height: 40,
                    width: 30),
                backgroundColor: AppColors.ButtonBG1,
                onPressed: () async {
                  signinInwithGoogle(context);
                },
                textColor: AppColors.font2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(6.0),
                text: "Signup with Google",
                fontSize: 25.0,
                ff: '',
              ),

              const SizedBox(
                height: 40,
              ),
              BigText(
                text: "OR",
                size: 25,
                fw: FontWeight.bold,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                  left: 15,
                  right: 15,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     alignLabelWithHint: true,
                      //     labelText: "Name",
                      //     floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 3, color: AppColors.MainColor2),
                      //         borderRadius: BorderRadius.circular(50.0)),
                      //     focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 3, color: AppColors.MainColor2),
                      //         borderRadius: BorderRadius.circular(50.0)),
                      //     contentPadding: const EdgeInsets.only(
                      //         left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your name';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value) {
                      //     tname = value!;
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "Phone Number",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.MainColor2),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.MainColor2),
                              borderRadius: BorderRadius.circular(50.0)),
                          contentPadding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length != 10) {
                            return 'Please enter a 10 digit phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          tphone = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: BigButton(
                          size: 25,
                          callback: () async {
                            if (_formKey.currentState?.validate() ?? true) {
                              _formKey.currentState?.save();
                              SignUp.signupfields = true;
                              print(tname + tphone);
                              // FirebaseAuth auth = FirebaseAuth.instance;
                              // print("Sending" + countrycode.text + Phone);

                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: "+91" + tphone,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {
                                    print("Verification Complete");
                                  },
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    print(e.message);
                                  },
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    SignUp.signup_verifyID = verificationId;
                                    print("Code Sent");
                                    Navigator.pushNamed(
                                        context, "/Primary_OTP");
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {
                                    print("TimeOutttttttttttt");
                                  });
                            }
                          },
                          text: 'Verify',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //       onPressed: () {
                      //         Navigator.pushNamed(context, "/Primary_Login",
                      //             arguments: [1]);
                      //       },
                      //       child: BigText(
                      //         text: "Already Have a Account ?",
                      //         size: 15,
                      //       )),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
