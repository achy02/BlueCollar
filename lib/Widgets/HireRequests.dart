// import 'package:bluecollar/Pages/page_Landing.dart';
// import 'package:bluecollar/Utils/AppColors.dart';
// import 'package:bluecollar/Widgets/CurrentStatus.dart';
// import 'package:bluecollar/Widgets/RequestWidget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class HireRequests extends StatefulWidget {
//   const HireRequests({super.key});

//   @override
//   State<HireRequests> createState() => _HireRequestsState();
// }

// class _HireRequestsState extends State<HireRequests> {
//   List<DocumentSnapshot> data = [];
//   Future<void> getRequested() async {
//     final CollectionReference Requested = FirebaseFirestore.instance
//         .collection('Hirers')
//         .doc(page_LandingState.auth.currentUser?.uid.toString())
//         .collection("Requested");
//     QuerySnapshot querySnapshot = await Requested.get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     data = documents;

//     for (DocumentSnapshot document in documents) {
//       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//       // print("prinit requestsss in home page");
//       // print(data);
//       // Process the document data...
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           CurrentStatus(
//             status: 'pending',
//             username: 'ABC',
//             imgUrl: img,
//           ),
//         ],
//       ),
//     );
//   }
// }
