import 'package:bluecollar/Widgets/BigText.dart';
import 'package:flutter/material.dart';

import '../Utils/AppColors.dart';

class RequestWidget extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl, address;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final int state;
  RequestWidget({
    required this.name,
    required this.message,
    required this.imageUrl,
    required this.onAccept,
    required this.onReject,
    this.address = "",
    this.state = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (state == 1) {
      // accepted

      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AlertDialog(
                    content: Container(
                      height: 425,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.purpleligher,
                              radius: 53,
                              child: ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Name: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$name",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Job Location: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$address",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Container(
                              child: Text(
                                "Job Description:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              width: 230,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: Container(
                                child: Text(
                                  message,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              // backgroundImage: AssetImage(imageUrl),
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            subtitle: Text(message),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Add your button action here
              },
              child: Text("Accepted"),
            ),
          ),
        ),
      );
    }
// /////////////////////////////////////////////////////////////////////////////////////////////////

    if (state == 2) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AlertDialog(
                    content: Container(
                      height: 425,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.purpleligher,
                              radius: 53,
                              child: ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Name: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$name",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Job Location: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$address",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Container(
                              child: Text(
                                "Job Description:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              width: 230,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: Container(
                                child: Text(
                                  message,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              // backgroundImage: AssetImage(imageUrl),
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            subtitle: Text(message),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Add your button action here
              },
              child: Text("Rejected"),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AlertDialog(
                    content: Container(
                      height: 425,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.purpleligher,
                              radius: 53,
                              child: ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Name: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$name",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              children: [
                                BigText(
                                  text: "Job Location: ",
                                  size: 15,
                                ),
                                BigText(
                                  text: "$address",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Container(
                              child: Text(
                                "Job Description:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              width: 230,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: Container(
                                child: Text(
                                  message,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              // backgroundImage: AssetImage(imageUrl),
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            subtitle: Text(message),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: onAccept,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onReject,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
