import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/userImage.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  final double size;
  final bool editable;
  final Function callbackVerifyimageUpload;

  ProfilePicture({
    this.size = 48.0,
    required this.editable,
    required this.callbackVerifyimageUpload,
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: userImage(
            editable: widget.editable,
            onFileChanged: (value) {
              setState(() {
                print("Printing imagges");
                print(value);
                this.imageUrl = value;
                if (widget.editable == false) {
                  widget.callbackVerifyimageUpload(true);
                }
              });
            }));
  }
}
