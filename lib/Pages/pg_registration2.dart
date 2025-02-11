import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Pages/page_signup.dart';

import 'package:flutter/material.dart';
import 'package:bluecollar/Widgets/RadioButton.dart';
import 'package:bluecollar/Widgets/ProfilePicture.dart';
import 'package:flutter/services.dart';

import '../Utils/AppColors.dart';

class pg_registration2 extends StatefulWidget {
  @override
  _pg_registration2State createState() => _pg_registration2State();
}

class _pg_registration2State extends State<pg_registration2> {
  String? _gender;
  final _formKey = GlobalKey<FormState>();
  bool picuploaded = false;
  bool picnotuploaded = false;

  late String _text = "";
  // ignore: non_constant_identifier_names
  late String name, Aadhaar_number, Age, taddress, email;
  String? Phone;

  @override
  Widget build(BuildContext context) {
    if (SignUp.signupfields == true) {
      Phone = SignUp.tphone.toString();
      name = SignUp.tname;
    } else {
      name = "";
      Phone = page_LandingState.auth.currentUser?.phoneNumber.toString();
    }
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: BigText(
                text: "Registration Form",
                size: 30,
                fw: FontWeight.bold,
              ),
            ),
            Center(
                child: Column(
              children: [
                picnotuploaded
                    ? Container(
                        child: BigText(
                          text: "**Please Upload a profile picture**",
                          size: 15,
                          colorr: AppColors.error,
                          ff: 'Playfair',
                        ),
                      )
                    : Container(),
                ProfilePicture(
                  size: 50.0,
                  editable: false,
                  callbackVerifyimageUpload: (stat) {
                    setState(() {
                      picuploaded = stat;
                      picnotuploaded = false;
                    });
                  },
                ),
              ],
            )),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        onSaved: (newValue) => {
                          name = newValue!,
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 119, 119, 119)),
                        ),
                      ),
                      Row(
                        children: [
                          CustomRadioButton(
                            label: 'Male',
                            value: _gender == 'Male',
                            onChanged: (bool value) {
                              setState(() {
                                _gender = value ? 'Male' : null;
                              });
                            },
                          ),
                          CustomRadioButton(
                            label: 'Female',
                            value: _gender == 'Female',
                            onChanged: (bool value) {
                              setState(() {
                                _gender = value ? 'Female' : null;
                              });
                            },
                          ),
                          CustomRadioButton(
                            label: 'Other',
                            value: _gender == 'Other',
                            onChanged: (bool value) {
                              setState(() {
                                _gender = value ? 'Other' : null;
                              });
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                        thickness: 1,
                      ),
                      TextFormField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                        ),
                        onSaved: (newValue) {
                          Age = newValue!;
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
                            _text = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: const InputDecoration(
                          labelText: 'Adhar Number',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^[01]')),
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (newValue) => {Aadhaar_number = newValue!},
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (newValue) => taddress = newValue!,
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.phone,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly
                      //   ],
                      //   maxLength: 10,
                      //   decoration:
                      //       const InputDecoration(labelText: 'Phone number'),
                      //       initialValue: Phone,
                      //       editi
                      // ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(labelText: 'Email Address'),
                        onSaved: (newValue) => email = newValue!,
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
                      const SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (picuploaded == true) {
                              if (_formKey.currentState?.validate() ?? true) {
                                _formKey.currentState?.save();
                                // Form is valid, so submit the data
                                FirebaseOperations.addHirer(
                                    page_LandingState.auth.currentUser?.uid,
                                    name,
                                    Age,
                                    _gender,
                                    Aadhaar_number,
                                    taddress,
                                    Phone);
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: const Text("Congratulations!"),
                                          content: const Text(
                                              "Your registration is successful"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        "/Home",
                                                        (route) => false);
                                              },
                                              child: Container(
                                                color: Colors.lightBlue,
                                                padding:
                                                    const EdgeInsets.all(14),
                                                child: const Text("okay",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        ));
                              }
                            } else {
                              setState(() {
                                picnotuploaded = true;
                              });
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
