import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:flutter/material.dart';
import 'package:bluecollar/Widgets/RadioButton.dart';
import 'package:bluecollar/Widgets/ProfilePicture.dart';
import 'package:flutter/services.dart';

class pg_registration extends StatefulWidget {
  const pg_registration({super.key});

  @override
  _pg_registrationState createState() => _pg_registrationState();
}

class _pg_registrationState extends State<pg_registration> {
  String? _gender;
  String? availability;
  bool picuploaded = false;
  bool picnotuploaded = false;

  String _selectedOption = 'Watchmen';
  late String name, Aadhaar_number, Experience, Bio, ExpectedSalary, taddress;
  late int Age;

  final _formKey = GlobalKey<FormState>();
  late String _text = "";

  @override
  Widget build(BuildContext context) {
    late String Address;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: BigText(
              text: "Worker Registration Form",
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
          // : Center(
          //     child: ProfilePicture(
          //     size: 50.0,
          //     editable: false,
          //     callbackVerifyimageUpload: (stat) {
          //       setState(() {
          //         picuploaded = stat;
          //       });
          //     },
          //   )),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              onSaved: (value) => name = value.toString(),
                              maxLength: 20,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                              ),
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
                              onSaved: (value) => Age = int.parse(value!),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Select Job Category",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 119, 119, 119)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: DropdownButton(
                                value: _selectedOption,
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Watchmen',
                                      child: Text('Watchmen')),
                                  DropdownMenuItem(
                                      value: 'Cook', child: Text('Cook')),
                                  DropdownMenuItem(
                                      value: 'Maid', child: Text('Maid')),
                                  DropdownMenuItem(
                                      value: 'BusDriver',
                                      child: Text('BusDriver')),
                                  DropdownMenuItem(
                                      value: 'BabySitter',
                                      child: Text('BabySitter')),
                                  DropdownMenuItem(
                                      value: 'CarDriver',
                                      child: Text('CarDriver')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                  });
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 1,
                              thickness: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Availability",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 119, 119, 119)),
                              ),
                            ),
                            Row(
                              children: [
                                CustomRadioButton(
                                  label: 'Full Time',
                                  value: availability == 'FT',
                                  onChanged: (bool value) {
                                    setState(() {
                                      availability = value ? 'FT' : null;
                                    });
                                  },
                                ),
                                CustomRadioButton(
                                  label: 'Part Time',
                                  value: availability == 'PT',
                                  onChanged: (bool value) {
                                    setState(() {
                                      availability = value ? 'PT' : null;
                                    });
                                  },
                                ),
                                CustomRadioButton(
                                  label: 'Both',
                                  value: availability == 'both',
                                  onChanged: (bool value) {
                                    setState(() {
                                      availability = value ? 'both' : null;
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
                              keyboardType: TextInputType.number,
                              maxLength: 12,
                              decoration: const InputDecoration(
                                labelText: 'Adhar Number',
                              ),
                              onSaved: (value) =>
                                  Aadhaar_number = value.toString(),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^[01]')),
                                LengthLimitingTextInputFormatter(12),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'[a-zA-Z]')),
                              ],
                              validator: (value) {
                                print("inside validator");
                                String? _previousValue = '';
                                _previousValue = value;
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 12) {
                                  return 'Please enter a valid Aadhaar number';
                                } else if (value.length > 12) {
                                  return _previousValue;
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
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: 'Address',
                              ),
                              onSaved: (value) => taddress = value.toString(),
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
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Experience/ none if not any'),
                              onSaved: (value) => Experience = value.toString(),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: "Bio",
                              ),
                              onSaved: (value) => Bio = value.toString(),
                            ),
                            TextFormField(
                              maxLength: 12,
                              decoration: const InputDecoration(
                                hintText: 'Enter your expected salary',
                              ),
                              onSaved: (value) =>
                                  ExpectedSalary = value.toString(),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                            const SizedBox(height: 16.0),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (picuploaded == true) {
                                    if (_formKey.currentState?.validate() ??
                                        true) {
                                      _formKey.currentState?.save();
                                      print("$Age $name $Aadhaar_number $Bio");
                                      FirebaseOperations.addWorker(
                                          page_LandingState
                                              .auth.currentUser?.uid
                                              .toString(),
                                          _selectedOption,
                                          name,
                                          Age,
                                          _gender,
                                          Aadhaar_number,
                                          Experience,
                                          Bio,
                                          ExpectedSalary,
                                          taddress,
                                          page_LandingState
                                              .auth.currentUser?.phoneNumber
                                              .toString(),
                                          availability.toString());
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    "Congratulations!"),
                                                content: const Text(
                                                    "Your registration is successful"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              "/workerHome",
                                                              (route) => false);
                                                    },
                                                    child: Container(
                                                      color: Colors.lightBlue,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child: const Text("okay",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
