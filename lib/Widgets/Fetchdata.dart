import 'package:bluecollar/Widgets/DisplayEmp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchData extends StatelessWidget {
  FetchData({super.key});
  final CollectionReference Workers =
      FirebaseFirestore.instance.collection('Workers');

  @override
  Widget build(BuildContext context) {
    print("Workers is " + Workers.toString());
    return Scaffold(
      body: StreamBuilder(
        stream: Workers.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            print("Length is :" + streamSnapshot.data!.docs.length.toString());
            print("Stream is :" + streamSnapshot.toString());

            return DisplayEMP(streamSnapshot: streamSnapshot);
          } else {
            print("NoData");
            return Container(
              color: Colors.amber,
              width: 100,
            );
          }
        },
      ),
    );
  }
}
