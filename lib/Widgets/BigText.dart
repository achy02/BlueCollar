import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color? colorr;
  final String text;
  final FontWeight? fw;
  final String? ff;
  double size;
  // ignore: non_constant_identifier_names
  TextOverflow OverFlow;
  BigText({
    Key? key,
    this.colorr = const Color(0xFF332d2b),
    required this.text,
    this.size = 20,
    this.fw = FontWeight.bold,
    this.OverFlow = TextOverflow.ellipsis,
    this.ff = 'Playfair',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: OverFlow,
      // style: TextStyle(
      //     color: colorr, fontFamily: ff, fontSize: size, fontWeight: fw),
      style: GoogleFonts.inter(color: colorr, fontSize: size, fontWeight: fw),
    );
  }
}
