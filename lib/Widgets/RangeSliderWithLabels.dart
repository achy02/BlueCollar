import 'package:flutter/material.dart';

class RangeSliderWithLabels extends StatefulWidget {
  final double start;
  final double end;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<RangeValues> onChanged;

  RangeSliderWithLabels({
    required this.start,
    required this.end,
    this.min = 0,
    required this.max,
    required this.onChanged,
    required this.unit,
  });

  @override
  _RangeSliderWithLabelsState createState() => _RangeSliderWithLabelsState();
}

class _RangeSliderWithLabelsState extends State<RangeSliderWithLabels> {
  RangeValues _values = RangeValues(0, 1);

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.start, widget.end);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RangeSlider(
          values: _values,
          min: widget.min,
          max: widget.max,
          onChanged: (RangeValues values) {
            setState(() {
              _values = values;
            });
            widget.onChanged(values);
          },
          labels: RangeLabels(
            "${(_values.start).toInt()}%",
            "${(_values.end).toInt()}%",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(_values.start).toInt()} -",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              " ${(_values.end).toInt()} (" + widget.unit + ")",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
