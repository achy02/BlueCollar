import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppRoundImage extends StatelessWidget {
  final ImageProvider provider;
  final double height, width;
  const AppRoundImage(
      {super.key,
      required this.provider,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory AppRoundImage.url(String url,
      {required double height, required double width}) {
    return AppRoundImage(
        provider: NetworkImage(url), height: height, width: width);
  }
  factory AppRoundImage.memory(Uint8List data,
      {required double height, required double width}) {
    return AppRoundImage(
        provider: MemoryImage(data), height: height, width: width);
  }
}
