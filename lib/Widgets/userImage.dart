import 'dart:io';

import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Pages/pg_Landing2.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'AppRoundImage.dart';

class userImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;
  final bool editable;
  userImage({super.key, required this.onFileChanged, required this.editable});

  @override
  State<userImage> createState() => _userImageState();
}

class _userImageState extends State<userImage> {
  final ImagePicker _picker = ImagePicker();
  bool img = false;
  @override
  void initState() {
    // TODO: implement initState
    // file checkign code//
    if (widget.editable == true) {
      final ref = storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child(page_LandingState.auth.currentUser!.uid.toString());

      ref.getDownloadURL().then((url) async {
        print("File exists!");
        final fileUrll = await ref.getDownloadURL();

        print("File exists:" + fileUrll);
        setState(() {
          imgURL = fileUrll;
          img = true;
        });
        // Do something with the file URL, such as display it in an Image.network widget
      }).catchError((error) {});
      //file checking code//
    } else {
      img = true;
    }
  }

  String? imgURL;
  @override
  Widget build(BuildContext context) {
    if (img == false) {
      return CircularProgressIndicator();
    } else {
      return Column(children: [
        if (imgURL == null)
          Icon(
            Icons.account_circle_rounded,
            size: 60,
            color: AppColors.font2,
          ),
        if (imgURL != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundImage.url(imgURL!, width: 140, height: 140),
          ),
        InkWell(
          onTap: () => _selectPhoto(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(imgURL != null ? "Change Photo" : "Select Photo"),
          ),
        )
      ]);
    }
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text("Pick a File"),
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

    if (file == null) {
      return;
    }
    File? finalimg;
    finalimg = await compressImage(file.path, 35);

    await _uploadFile(
        finalimg!.path); // pass file path to _uploadFile() function
  }
  // Future _pickImage(ImageSource source) async {
  //   final PickedFile =
  //       await _picker.pickImage(source: source, imageQuality: 50);
  //   if (PickedFile == null) {
  //     return;
  //   }
  //   var file = await ImageCropper().cropImage(
  //       sourcePath: PickedFile.path,
  //       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
  //   if (file == null) {
  //     return;
  //   }
  //   file = await compressImage(file.path, 35);
  //   0 - await _uploadFile(file!.path.toString());
  // }

  Future<File?> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child(page_LandingState.auth.currentUser!.uid.toString());
    // .child('${DateTime.now()}.${p.extension(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imgURL = fileUrl;
      widget.onFileChanged(fileUrl);
    });
  }
  // Future _uploadFile(String path) async {
  //   final ref = storage.FirebaseStorage.instance
  //       .ref()
  //       .child('images')
  //       .child('${DateTime.now()}.${p.extension(path)}');

  //   final result = await ref.putFile(File(path));
  //   final fileUrl = await result.ref.getDownloadURL();

  //   setState(() {
  //     imgURL = fileUrl;
  //     widget.onFileChanged(fileUrl);
  //   });
  // }
}
