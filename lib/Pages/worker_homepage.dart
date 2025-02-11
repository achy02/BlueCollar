import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:bluecollar/Widgets/Bottom_NavBar_Worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bluecollar/Widgets/ProfilePicture.dart';
import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/RequestWidget.dart';

class worker_homepage extends StatefulWidget {
  const worker_homepage({super.key});
  static late Map<String, dynamic> workerinfo;
  @override
  State<worker_homepage> createState() => _worker_homepageState();
}

class _worker_homepageState extends State<worker_homepage> {
  Widget RowELement(
      {@required colorr, required String title, required String subtitile}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(top: 30, left: 30),
      height: 120,
      width: 305,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [
              Color(0xFF3366FF),
              Color(0xFF00CCFF),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        color: colorr,
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
            ),
            SizedBox(
              height: 5,
            ),
            BigText(
              colorr: Colors.white,
              text: subtitile,
              size: 19,
            )
          ]),
    );
  }

  late String name = "Not init";
  String? uid = page_LandingState.auth.currentUser?.uid.toString();
  // String img='';
  late Map<String, dynamic> data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initing");
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('Workers');
    final DocumentReference myDocument =
        myCollection.doc(page_LandingState.auth.currentUser?.uid.toString());
    myDocument.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(
          "Existss",
        );
        Map<String, dynamic> ds =
            documentSnapshot.data() as Map<String, dynamic>;
        worker_homepage.workerinfo = ds;
        setState(() {
          data = ds;
          name = data!['Name'];
          print(data!['img']);
        });
        // Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
        // document exists, you can access its data using documentSnapshot.data()
      } else {
        print("Nahi hai");
        setState(() {
          name = "null";
        });
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "/Register_Hirer", (route) => false);

        // document does not exist
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String namee = "Ramesh Tiwari";

    return Scaffold(
        bottomNavigationBar: Bottom_NavBar_Worker(indexx: 0),
        appBar: AppBar(
            foregroundColor: Colors.white,
            title: BigText(
              size: 22,
              text: "Blue-Collar",
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
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: CircleAvatar(
                foregroundColor: Colors.black,
                // backgroundColor: AppColors.purpleligher,
                radius: 68,
                // child: InkWell(
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   child: AppRoundImage.url(img, width: 80, height: 80),
                // ),
                child: data.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          data['img'],
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 30, left: 83),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: "Hello, ",
                          fw: FontWeight.bold,
                          size: 18,
                        ),
                        BigText(
                          text: "$name!",
                          fw: FontWeight.bold,
                          size: 25,
                        ),
                      ],
                    )),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 15),
                child: BigText(
                    text: "Start your work jorney with Blue-Collar today",
                    size: 15,
                    fw: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 10),
                    child: Row(
                      children: [
                        RowELement(
                          colorr: AppColors.backgroundColor2,
                          title: "Jobs",
                          subtitile: "Apply for Blue-collar jobs too",
                        ),
                        RowELement(
                            colorr: AppColors.backgroundColor2,
                            title: "What do we do?",
                            subtitile: "We help in easy job seeking"),
                        RowELement(
                            colorr: AppColors.backgroundColor2,
                            title: "Blue-Collar",
                            subtitile: "Apply without any problem here!"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 155),
                child: BigText(text: "Jobs we have here", fw: FontWeight.bold)),
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
          ]),
        )
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20),
        //   child: Column(
        //     children: [
        // Container(
        //   alignment: Alignment.center,
        //   child: BigText(
        //     // ignore: prefer_interpolation_to_compose_strings
        //     text: "Welcome! ",
        //     size: 25,
        //     fw: FontWeight.bold,
        //   ),
        // ),
        // Container(
        //   child: BigText(
        //     text: "$name!",
        //     size: 25,
        //     fw: FontWeight.bold,
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.all(40),
        //   child: CircleAvatar(
        //     // backgroundColor: AppColors.purpleligher,
        //     radius: 53,
        //     // child: InkWell(
        //     //   splashColor: Colors.transparent,
        //     //   highlightColor: Colors.transparent,
        //     //   child: AppRoundImage.url(img, width: 80, height: 80),
        //     // ),
        //     child: data.isNotEmpty
        //         ? ClipOval(
        //             child: Image.network(
        //               data['img'],
        //               width: 140,
        //               height: 140,
        //               fit: BoxFit.cover,
        //             ),
        //           )
        //         : Container(),
        //   ),
        // ),
        // Container(
        //     child: BigButton(
        //         text: "Logout",
        //         size: 15,
        //         width: 0.50,
        //         callback: () {
        //           page_LandingState.auth.signOut();
        //           Navigator.pushNamedAndRemoveUntil(
        //               context, "/", (route) => false);
        //         })),
        // ],
        // ),
        // ),
        // ],
        // ),
        );
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
