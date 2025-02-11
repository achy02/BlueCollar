import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigButton.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar.dart';
import 'package:bluecollar/Widgets/HireRequests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bluecollar/Widgets/CurrentStatus.dart';

class HomeScreen extends StatefulWidget {
  static Map<String, dynamic> userData = {};
  static Position? locationdata = null;
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget GridElement({required String image, required String name}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: AppColors.containercolor1, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child:
                  CircleAvatar(radius: 35, backgroundImage: AssetImage(image)),
            ),
            const SizedBox(
              height: 10,
            ),
            BigText(
              text: name,
              ff: 'Roboto',
              size: 17,
            )
          ],
        ));
  }

  Widget RowELement(
      {@required colorr, required String title, required String subtitile}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(top: 30, left: 30),
      height: 120,
      width: 305,
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //     colors: [
        //       Color(0xFF3366FF),
        //       Color(0xFF00CCFF),
        //     ],
        //     begin: FractionalOffset(0.0, 0.0),
        //     end: FractionalOffset(1.0, 0.0),
        //     stops: [0.0, 1.0],
        //     tileMode: TileMode.clamp),
        color: AppColors.ThemeBlue,

        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(
              colorr: Colors.white,
              text: title,
              size: 22,
              ff: 'Roboto',
            ),
            SizedBox(
              height: 5,
            ),
            BigText(
              colorr: Colors.white,
              text: subtitile,
              size: 19,
              ff: 'Roboto',
            )
          ]),
    );
  }

  late String nameU = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchlocation();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final PermissionStatus permissionStatus =
        await Permission.locationWhenInUse.request();
    if (permissionStatus == PermissionStatus.granted) {
      print("permission granterd");
      fetchlocation();
    } else {
      print("permission denied");
    }
  }

  void fetchlocation() async {
    print('Fetching location...');

    Position currentPosition =
        await Geolocator.getCurrentPosition().then((value) {
      print('Printing location:' + value.toString());
      setState(() {
        HomeScreen.locationdata = value;
      });
      return value;
    }).catchError((e) {
      print('Error getting location:');
      print(e);
      return null;
    });
  }

  void getdata() {
    print("initing");
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('Hirers');

    final DocumentReference myDocument =
        myCollection.doc(page_LandingState.auth.currentUser?.uid.toString());
    myDocument.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(
          "Existss",
        );
        var data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          nameU = data['Name'];
          HomeScreen.userData = data;
          print(HomeScreen.userData["Name"]);
        });
        // Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
        // document exists, you can access its data using documentSnapshot.data()
      } else {
        print("Nahi hai");
        setState(() {
          nameU = "null";
        });
      }
      ;

      ///fetching requestss
    });
  }

  @override
  Widget build(BuildContext context) {
    String namee = nameU;
    bool showrequests = false;
    final String? name = page_LandingState.auth.currentUser?.uid.toString();
    // getdata();
    if (nameU == "") {
      getdata();
    }

    print("buildinng");
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final maxWidth = constraints.maxWidth;
      final scaleFactor = maxWidth / 400; // assuming 400 is the base width
      final fontSize = 20.0 * scaleFactor;
      final fontSizeB = 35.0 * scaleFactor;
      final fontSizes = 18.0 * scaleFactor;
      final containerwidth = 200 * scaleFactor;
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Bottom_NavBar(indexx: 0),
          appBar: AppBar(
              backgroundColor: AppColors.ThemeBlue2,
              foregroundColor: Colors.white,
              title: BigText(
                text: "Blue-Collar",
                size: 22,
                fw: FontWeight.bold,
                colorr: Colors.white,
              ),
              centerTitle: true,
              elevation: 0.0,
              flexibleSpace: Container(
                  decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF3366FF),
                      Color(0xFF00CCFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ))),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BigText(
                        text: "Hello, ",
                        fw: FontWeight.bold,
                        size: 18,
                      ),
                      BigText(
                        text: "$namee!",
                        fw: FontWeight.bold,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 30),
                    child: BigText(
                        text: "Lets get started and Hire workers!",
                        size: 15,
                        fw: FontWeight.bold)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 10),
                    child: Row(
                      children: [
                        RowELement(
                          colorr: AppColors.backgroundColor2,
                          title: "Workers Near By",
                          subtitile: "Now hire Blue-collar wokers too",
                        ),
                        RowELement(
                            colorr: AppColors.backgroundColor2,
                            title: "What do we do?",
                            subtitile: "We help in easy hiring"),
                        RowELement(
                            colorr: AppColors.backgroundColor2,
                            title: "Blue-Collar",
                            subtitile: "Hire trust worthy workers here"),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: BigText(
                        text: "Whom can you hire here!", fw: FontWeight.bold)),
                SizedBox(
                  height: 25,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      CircularAvatarItem(
                        avatarUrl:
                            "assets/Images/Watchmen.png", // Replace with your actual avatar image URL
                        text: 'Watchmen',
                      ),
                      CircularAvatarItem(
                        avatarUrl: "assets/Images/BusDriver.png",
                        text: 'Bus Driver',
                      ),
                      CircularAvatarItem(
                        avatarUrl: "assets/Images/BabySitter.png",
                        text: 'Baby Sitter',
                      ),
                      CircularAvatarItem(
                        avatarUrl: "assets/Images/CardDriver.png",
                        text: 'Car driver',
                      ),
                      CircularAvatarItem(
                        avatarUrl: "assets/Images/Cook.png",
                        text: 'Cook',
                      ),
                      CircularAvatarItem(
                        avatarUrl: "assets/Images/maid.png",
                        text: 'Maid',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: BigText(
                        text: "Lets start hiring!", fw: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 10),
                  child: BigButton(
                    text: "Hire Now!",
                    size: 20,
                    callback: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title:
                                    const Text("Do you want to start hiring?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/TypeGrid', (route) => false);
                                    },
                                    child: Container(
                                      color: Colors.lightBlue,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Yess",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    width: 0.45,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CircularAvatarItem extends StatelessWidget {
  final String avatarUrl;
  final String text;

  CircularAvatarItem({required this.avatarUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage(avatarUrl),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
