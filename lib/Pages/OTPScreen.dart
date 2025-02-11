// ignore_for_file: file_names

import 'dart:math';

import 'package:bluecollar/Pages/page_Login.dart';
import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  bool OTPInvalid = false;

  OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 66,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/Images/Otp.jpeg',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 10),
                  BigText(text: "Enter The OTP", size: 40, fw: FontWeight.bold),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: " Phone Verification",
                    size: 20,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    // ignore: avoid_print

                    onChanged: (value) {
                      print("Value");
                      code = value;
                    },
                    onCompleted: (pin) {
                      print(pin);
                      code = pin;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BigButton(
                    size: 22,
                    text: "Verify OTP ",
                    width: 0.60,
                    callback: () async {
                      // Create a PhoneAuthCredential with the code
                      try {
                        print("In Try");
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: page_Login.verifyId,
                                smsCode: code);
                        await page_LandingState.auth
                            .signInWithCredential(credential);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/Home", (route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-verification-code') {
                          print('Wrong OTP');
                          setState(() {
                            widget.OTPInvalid = true;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }

                      // Sign the user in (or link) with the credential
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          child: Text(
                            "Edit Phone Number?",
                            style:
                                TextStyle(color: AppColors.font2, fontSize: 15),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
