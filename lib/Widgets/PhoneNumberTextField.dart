import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BigButton.dart';

class PhoneNumberTextField extends StatefulWidget {
  final String text;
  final TextEditingController? tc;
  final Function callback;
  final Function callback2;
  late String phone;

  PhoneNumberTextField(
      {super.key,
      required this.text,
      this.tc,
      required this.phone,
      required this.callback,
      required this.callback2});

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  String custo = "";
  bool error = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(10)),
          child: Form(
            key: _formKey,
            child: Row(children: [
              SizedBox(
                  width: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    controller: widget.tc,
                  )),
              Text(
                "|",
                style: TextStyle(
                    fontSize: 35,
                    color: AppColors.MainColor2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    custo = value!;
                  },
                  keyboardType: TextInputType.phone,
                  onChanged: (
                    value,
                  ) {
                    widget.phone = value;
                    print(_formKey);

                    widget.callback(widget.phone);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Phone"),
                  style: TextStyle(fontSize: 25),
                ),
              )
            ]),
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: error
                ? BigText(
                    text: "Please Enter a valid phone number!",
                    size: 14,
                    colorr: Colors.red,
                  )
                : null),
        const SizedBox(
          height: 45,
        ),
        Container(
          width: 250,
          child: BigButton(
              text: "Send OTP",
              size: 20,
              width: 0.82,
              callback: () async {
                _formKey.currentState?.validate();
                if (custo == null || custo == "" || custo.length < 10) {
                  print("Valid nahi hai");
                  setState(() {
                    error = true;
                  });
                } else {
                  setState(() {
                    error = false;
                  });
                  widget.callback2();
                }

                print("Done");
              }),

          // ignore: use_build_context_synchronously
        ),
      ],
    );
    ;
  }
}
