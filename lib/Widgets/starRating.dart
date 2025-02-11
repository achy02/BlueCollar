import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final ValueChanged<int>? onChanged;

  StarRating({Key? key, this.onChanged}) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStar(1),
        buildStar(2),
        buildStar(3),
        buildStar(4),
        buildStar(5),
      ],
    );
  }

  Widget buildStar(int rating) {
    return GestureDetector(
      child: Icon(
        rating <= _rating ? Icons.star : Icons.star_border,
        color: Colors.orange,
        size: 30,
      ),
      onTap: () {
        setState(() {
          _rating = rating;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_rating);
        }
      },
    );
  }
}
