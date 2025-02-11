import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String label;
  final Function onChanged;
  final bool value;

  CustomRadioButton(
      {required this.label, required this.onChanged, required this.value});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    String label = widget.label;

    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Tapped");
            },
            child: Radio(
              value: widget.value,
              groupValue: true,
              onChanged: (bool? value) {
                widget.onChanged(value);
              },
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
