import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/starRating.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'BigText.dart';

class CurrentStatus extends StatelessWidget {
  final String username;
  final String status;
  final int role;
  final String Phone, workerrole, hid, wid;
  final bool isRated;

  final String imgUrl;

  CurrentStatus(
      {required this.username,
      required this.status,
      required this.imgUrl,
      required this.role,
      this.Phone = "",
      this.workerrole = "",
      this.hid = "",
      this.wid = "",
      this.isRated = false});

  @override
  Widget build(BuildContext context) {
    print("role is $role");
    if (role == 1) {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: Image.network(
                imgUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ), // Replace with your own image
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Status:" + status,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Add your button action here
                  },
                  child: Text(status),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (role == 2) {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                imgUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ), // Replace with your own image
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  child: Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text("Contact " + username),
                              // content: const Text(
                              //     "Phone number: xxxxxxxxxxxxx"),
                              content: SelectableText("Phone number: " + Phone),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.lightBlue,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ));
                  },
                  child: Text(
                    'View',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: isRated
                    ? ElevatedButton(
                        onPressed: null,
                        child: Text(
                          'Rated',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Rate ' + username),
                                content: StarRating(
                                  onChanged: (rating) {
                                    // String a = "01234";
                                    // print(a[1]);
                                    FirebaseOperations.rate(
                                        wid, hid, workerrole, rating);

                                    Navigator.of(context).pop(rating);
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              print('Selected rating: $value');
                              // Do something with the selected rating, e.g. submit it to a server
                            }
                          });
                        },
                        child: Text('Rate'),
                      ),
              ),
            ),
          ],
        ),
      );
    } else if (role == 3) {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                imgUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ), // Replace with your own image
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Status:" + status,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // Add your button action here
                  },
                  child: Text('Rejected'),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
