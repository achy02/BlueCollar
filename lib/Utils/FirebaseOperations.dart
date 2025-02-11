import 'package:bluecollar/Pages/HomeScreen.dart';
import 'package:bluecollar/Widgets/userImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class FirebaseOperations {
  static Future<void> addWorker(
      String? uid,
      String Type,
      String tname,
      tAge,
      tgender,
      tAadhaar_number,
      tExperience,
      tBio,
      tExpectedSalary,
      taddress,
      tphone,
      tavailability) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //     .then((value) {
    //   location = GeoPoint(value.latitude, value.longitude);
    //   return value;
    // });

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('images/' + uid.toString());
    final url = await imageRef.getDownloadURL();
    print('Download URL: $url');

    GeoPoint location = GeoPoint(position.latitude, position.longitude);
    // Call the user's CollectionReference to add a new user
    CollectionReference DB =
        FirebaseFirestore.instance.collection('PendingWorkers');

    CollectionReference DB2 = FirebaseFirestore.instance.collection('Workers');
    // .doc(Type)
    // .collection(Type);
    DocumentReference userDocRef = DB.doc(uid.toString());

    DocumentReference userDocRef2 = DB2.doc(uid.toString());
    print("adding data tot uid:" + uid.toString());

    userDocRef
        .set({
          'Name': tname.toString(), // John Doe
          'Age': int.parse(tAge.toString()), // Stokes and Sons
          'Gender': tgender, // 42
          'Aadhar_Number': tAadhaar_number, // 42
          'Address': taddress, // 42
          'Bio': tBio, // 42
          'Expected_Salary': tExpectedSalary, // 42
          'Role': Type, // 42
          'Phone': tphone,
          'Experience': tExperience,
          'location': location,
          'img': url,
          'availability': tavailability,
        })
        .then((value) => print("User Addedddd"))
        .catchError((error) => print("Failed to add user: $error"));
    userDocRef2
        .set({
          'Name': tname.toString(), // John Doe
          'Age': int.parse(tAge.toString()), // Stokes and Sons
          'Gender': tgender, // 42
          'Aadhar_Number': tAadhaar_number, // 42
          'Address': taddress, // 42
          'Bio': tBio, // 42
          'Expected_Salary': tExpectedSalary, // 42
          'Role': Type, // 42
          'Phone': tphone,
          'Experience': tExperience,
          'location': location,
          'img': url,
          'availability': tavailability,
          'isApproved': false,
        })
        .then((value) => print("User Addedddd"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  // switch (Type) {
  //   case "Watchmen":
  //     break;
  //   case "BabySitter":
  //     DB = FirebaseFirestore.instance.collection('Workers');

  //     break;
  //   case "Maid":
  //     DB = FirebaseFirestore.instance.collection('Workers');

  //     break;
  //   case "Cook":
  //     DB = FirebaseFirestore.instance.collection('Workers');

  //     break;
  //   case "Driver":
  //     DB = FirebaseFirestore.instance.collection('Workers');

  //     break;

  //   default:
  //     print("error");
  //     break;
  // }

  static Future<void> addHirer(uid, String tname, tAge, tgender,
      tAadhaar_number, taddress, tPhone) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference DB = FirebaseFirestore.instance.collection('Hirers');
    DocumentReference userDocRef = DB.doc(uid);

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('images/' + uid.toString());
    final url = await imageRef.getDownloadURL();
    print('Download URL: $url');

    await userDocRef
        .set({
          'Name': tname.toString(),
          'Age': int.parse(tAge),
          'Gender': tgender,
          'Aadhar_Number': tAadhaar_number,
          'Address': taddress,
          'Phone': tPhone,
          'img': url,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    await userDocRef.collection('Favourites').doc().set({});
  }

  static Future<Map<String, dynamic>> getUserData(
      String collection, String? uid) async {
    print("Getting user data");
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('Hirers');
    final DocumentReference myDocument = myCollection.doc(uid);
    final DocumentSnapshot documentSnapshot = await myDocument.get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  static Future<void> addFavourites(uid, DocumentSnapshot ds) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference DB = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(uid)
        .collection("Favourites");
    final DocumentReference newDocRef = DB.doc(uid);
    final Object? sourceData = ds.data();
    await newDocRef
        .set(sourceData)
        .then((value) => {print("Added to favourites successfully")});
  }

  static Future<void> addRequests(uid, DocumentSnapshot ds, userInput) async {
    // add profile pic and name
    print("Printing hokme screen userdata," + HomeScreen.userData.toString());
    String name, ppurl, hname, hppurl, address;
    name = ds['Name'];
    ppurl = ds['img'];
    hname = HomeScreen.userData['Name'];
    hppurl = HomeScreen.userData['img'];
    address = HomeScreen.userData['Address'];

    CollectionReference DB = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(uid)
        .collection("Requested");

    CollectionReference DBworker = FirebaseFirestore.instance
        .collection('ApprovedWorkers')
        .doc(ds['Role'])
        .collection(ds['Role'])
        .doc(ds.id.toString())
        .collection("Requests");
    DocumentReference hirerref = DBworker.doc(uid);
    DocumentReference requestedbyhirer = DB.doc(ds.id);

    await requestedbyhirer.set({
      "status": "Pending",
      "img": ppurl,
      "Name": name,
      "Desc": userInput,
      "Phone:": ds['Phone'],
      'isRated': false,
      'role': ds['Role'],
    });
    await hirerref.set({
      "status": "Pending",
      "img": hppurl,
      "Name": hname,
      "Desc": userInput,
      "Address": address,
    });
    print("Added requests succesfullyy");
    // final DocumentReference newDocRef = DB.doc();
    // final Object? sourceData = ds.data();
    // await newDocRef
    //     .set(sourceData)
    //     .then((value) => {print("Added to Requests successfully")});
  }

  static Future<void> rate(workerid, hirerid, role, ratingg) async {
    print("in rating, uid:$workerid hid:$hirerid");
    CollectionReference hirersideRequest = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(hirerid)
        .collection('Requested');
    DocumentReference hirersidereq = hirersideRequest.doc(workerid);

    CollectionReference Approvedworker = FirebaseFirestore.instance
        .collection('ApprovedWorkers')
        .doc(role)
        .collection(role);
    DocumentReference workerr = Approvedworker.doc(workerid);

    try {
      DocumentSnapshot snapshot = await workerr.get();
      if (snapshot.exists && snapshot.data() != null) {
        dynamic data = snapshot.data()!;
        if (data.containsKey('rating')) {
          dynamic ratingValue = data['rating'];
          int ratingsnumber = data['ratings'];
          if (ratingValue != null) {
            double rating = ratingValue;
            ratingsnumber++;
            print(
                "(($ratingValue * $ratingsnumber-1)) + $ratingg) / $ratingsnumber the new rating");
            rating = ((rating * (ratingsnumber - 1)) + ratingg) / ratingsnumber;

            await hirersidereq.update({
              "isRated": true,
            });
            workerr.update({
              'rating': rating,
              'ratings': ratingsnumber,
            });
            return;
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    workerr.update({
      'rating': ratingg.toDouble(),
      'ratings': 1,
    });
    // await hirersidereq.update({
    //   // "isRated": true,
    // });
  }

  static Future<void> Requestaccept(
      uid, String hid, String role, bool accepted) async {
    // Call the user's CollectionReference to add a new user

    // add profile pic and name
    print("Printing hokme screen userdata," + HomeScreen.userData.toString());
    // String name, ppurl, hname, hppurl;
    // name = ds['Name'];
    // ppurl = ds['img'];
    // hname = HomeScreen.userData['Name'];
    // hppurl = HomeScreen.userData['img'];

    CollectionReference DB = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(hid)
        .collection("Requested");

    CollectionReference DBworker = FirebaseFirestore.instance
        .collection('ApprovedWorkers')
        .doc(role)
        .collection(role)
        .doc(uid)
        .collection("Requests");
    DocumentReference hirerref = DBworker.doc(hid);
    DocumentReference requestedbyhirer = DB.doc(uid);
    print("uid:" + uid);
    print("hid:" + hid);
    if (accepted == true) {
      await requestedbyhirer.update({
        "status": "Accepted",
      });
      await hirerref.update({
        "status": "Accepted",
      });
    } else {
      await requestedbyhirer.update({
        "status": "Rejected",
      });

      await hirerref.update({
        "status": "Rejected",
      });
    }
    print("Accepted requests succesfullyy");
    // final DocumentReference newDocRef = DB.doc();
    // final Object? sourceData = ds.data();
    // await newDocRef
    //     .set(sourceData)
    //     .then((value) => {print("Added to Requests successfully")});
  }

  static Future<void> removeFavourites(uid, workeruid) async {
    CollectionReference DB = FirebaseFirestore.instance
        .collection('Hirers')
        .doc(uid)
        .collection("Favourites");
    DocumentReference dr = DB.doc(workeruid);
    await dr.delete();
  }

  static Future<void> updateHirerData(String uid, String newName, String newAge,
      String newAddress, String newEmail) async {
    CollectionReference hirerDB =
        FirebaseFirestore.instance.collection('Hirers');
    DocumentReference hirerDocRef = hirerDB.doc(uid);
    print("new values: $newName $newAge");
    await hirerDocRef
        .update({
          'Name': newName,
          'Age': int.parse(newAge),
          'Address': newAddress,
          'Email': newEmail,
        })
        .then((value) {})
        .catchError((error) {});
  }
}
