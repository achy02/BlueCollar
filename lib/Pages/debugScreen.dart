import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:flutter/material.dart';

class debugScreen extends StatelessWidget {
  const debugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget GridElement({required String name, required String path}) {
      return GestureDetector(
        onTap: () {
          print("Called");
          Navigator.pushNamed(context, path);
          print("showing snack bar");
          // _showSnackbar(context);
        },
        onHorizontalDragEnd: (details) {
          print(details.velocity);
          print("Called");
          Navigator.pushNamed(context, path);
        },
        child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: AppColors.font2, width: 2),
                color: AppColors.searchblue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                BigText(
                  text: name,
                  ff: 'Roboto',
                  size: 20,
                  fw: FontWeight.bold,
                  colorr: Colors.black,
                )
              ],
            )),
      );
    }

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                color: AppColors.ThemeBlue2),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.13,
            child: Container(
              padding: EdgeInsets.only(top: 25),
              alignment: Alignment.topCenter,
              child: BigText(
                text: "DebugScreen",
                ff: '',
                size: 45,
                colorr: Colors.white,
              ),
            ),
          ),
          // Container(
          //     height: 100,
          //     child: LocationSearchBar(
          //         apiKey: "9eeae45f457a47d2accda82162f83462")),
          Expanded(
            child: Container(
              height: 500,
              padding: EdgeInsets.only(top: 25),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 2.30,
                children: [
                  GridElement(name: "Start", path: '/landing1'),
                  GridElement(name: "SignUp", path: '/Signup'),
                  GridElement(
                    name: "Landing2",
                    path: '/landing',
                  ),
                  GridElement(name: "Home", path: '/Home'),
                  GridElement(name: "Login", path: '/Login'),
                  GridElement(name: "Primary Login", path: '/Primary_Login'),
                  GridElement(name: "Primary Login OTP", path: '/Primary_OTP'),
                  GridElement(name: "TypeGrid", path: '/TypeGrid'),
                  // GridElement(name: "Role Choose", path: '/Role'),
                  GridElement(name: "WorkerList", path: '/workerPage'),
                  GridElement(name: "WorkerListFuture", path: '/fetchFuture'),
                  GridElement(name: "OTP SCREEN", path: '/OTP'),
                  GridElement(name: "WorkerProfile**", path: '/workerprofile'),
                  GridElement(name: "Registration", path: '/Register_Hirer'),
                  GridElement(name: "EditWorker", path: '/editWorker'),
                  GridElement(name: "EditHirer", path: '/editHirer'),
                  GridElement(name: "Worker Home", path: '/workerHome'),
                  GridElement(
                      name: "Registration Worker", path: '/Register_Worker'),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

void _showSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    content: Text(
      'Tap nahi Swipe karrr!',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    duration: Duration(seconds: 3),
    margin: EdgeInsets.fromLTRB(
      30.0,
      0.0,
      30.0,
      MediaQuery.of(context).viewInsets.bottom + 260.0,
    ),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.blue,
      onPressed: () {
        // Do something when the user presses the action button
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
