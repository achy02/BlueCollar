import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Utils/FirebaseOperations.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeContainer extends StatelessWidget {
  final DocumentSnapshot ds;
  final String img;
  final bool favs;
  final int dist;
  const EmployeeContainer(
      {super.key,
      required this.ds,
      this.favs = false,
      required this.img,
      required this.dist});
  @override
  Widget build(BuildContext context) {
    final data = ds.data() as Map<String, dynamic>;
    String rating = "0.0", numberratings = "0";
    if (data.containsKey('rating')) {
      // The field exists in the document
      rating = data['rating'].toStringAsFixed(1);
      numberratings = data['ratings'].toStringAsFixed(0);
      if (data['ratings'] > 1000) {
        numberratings = (data["ratings"] / 1000).toString() + "K";
      }
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size screenSize = MediaQuery.of(context).size;

      // Calculate the scale factor
      double scaleX = screenSize.width / 360;
      double scaleY = screenSize.height / 400;
      double scaleFactor = scaleX < scaleY ? scaleX : scaleY;
      // final maxWidth = constraints.maxWidth;
      // final scaleFactor = maxWidth / 400; // assuming 400 is the base width
      final fontSize = 16.0 * scaleFactor;
      final fontSizeB = 21.0 * scaleFactor;
      final containerwidth = 210 * scaleFactor;
      final containerheight = 185 * scaleFactor;
      return Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 25, left: 10, right: 10),
        height: containerheight,
        decoration: BoxDecoration(
          color: AppColors.ThemeBlue2,
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [
                Color(0xFF3366FF),
                Color(0xFF00CCFF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(-5, 7), // changes position of shadow
            ),
          ],
        ),
        child: Column(children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: EdgeInsets.only(
                    top: (containerheight / 5), left: 8, right: 8),
                // ignore: prefer_const_constructors
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 55,
                  child: CircleAvatar(
                    backgroundColor: AppColors.purpleligher,
                    radius: 53,
                    // child: InkWell(
                    //   splashColor: Colors.transparent,
                    //   highlightColor: Colors.transparent,
                    //   child: AppRoundImage.url(img, width: 80, height: 80),
                    // ),
                    child: ClipOval(
                      child: Image.network(
                        img,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: containerwidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 170,
                            padding: EdgeInsets.only(top: 15, left: 8),
                            child: BigText(
                              text: ds['Name'],
                              ff: "",
                              size: fontSizeB - 3,
                              colorr: AppColors.font1,
                              fw: FontWeight.bold,
                            ),
                          ),
                          favs
                              ? Container(
                                  padding: EdgeInsets.only(top: 2),
                                  alignment: Alignment.centerRight,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.ThemeBlue,
                                    radius: 25,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete_forever,
                                          size: fontSizeB + fontSizeB * 0.38,
                                        ),
                                        color: Colors.redAccent,
                                        onPressed: () async {
                                          bool confirmed = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirmation'),
                                                content: Text(
                                                    'Are you sure you want to remove ' +
                                                        ds['Name'] +
                                                        ' from favourites?'),
                                                actions: [
                                                  TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        FirebaseOperations
                                                            .removeFavourites(
                                                                page_LandingState
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid,
                                                                ds.id);
                                                      }),
                                                  TextButton(
                                                    child: Text('No'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: BigText(
                              text: "Age: " + ds['Age'].toString(),
                              ff: "",
                              size: fontSize,
                              colorr: AppColors.font1,
                              fw: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: BigText(
                              text: ds['Gender'] == "Other"
                                  ? "G: Other"
                                  : "G: " + ds['Gender'].toString(),
                              ff: "",
                              size: fontSize,
                              colorr: AppColors.font1,
                              fw: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: BigText(
                              text: "Dist: " + dist.toString() + "KM",
                              ff: "",
                              size: fontSize * 0.80,
                              colorr: AppColors.font1,
                              fw: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(right: (containerwidth * 0.24)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber[400],
                                ),
                                BigText(
                                  text: "$rating ",
                                  ff: "",
                                  size: fontSize,
                                  colorr: AppColors.font1,
                                  fw: FontWeight.bold,
                                ),
                                BigText(
                                  text: "($numberratings)",
                                  size: fontSize - 5,
                                  ff: "",
                                  colorr: AppColors.font1,
                                  fw: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: containerwidth * 0.80,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Tapped on" + ds['Name']);
                          Navigator.pushNamed(context, "/workerprofile",
                              arguments: [ds, favs]);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(
                              text: "View Details",
                              ff: '',
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      );
    });
  }
}
