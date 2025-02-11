import 'dart:async';

import 'package:bluecollar/Utils/AppColors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String textt;
  // final TextEditingController TC;
  final List<TextInputFormatter>? formaters;
  final Function Cback;

  CustomTextField(
      {super.key,
      required this.textt,
      required this.Cback,
      required this.formaters});
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: widget.textt,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: AppColors.MainColor2),
              borderRadius: BorderRadius.circular(50.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: AppColors.MainColor2),
              borderRadius: BorderRadius.circular(50.0)),
          contentPadding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        ),
        style: const TextStyle(
            fontSize: 20.0,
            height: 2.0,
            color: Colors.black,
            fontFamily: 'Playfair',
            fontWeight: FontWeight.bold),
        onChanged: (value) {
          print("Callback $value");
          widget.Cback(value);
        },
        inputFormatters: widget.formaters,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
