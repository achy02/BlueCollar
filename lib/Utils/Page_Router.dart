import 'package:bluecollar/Pages/HomeScreen.dart';
import 'package:bluecollar/Pages/OTPScreen.dart';
import 'package:bluecollar/Pages/Requested.dart';
import 'package:bluecollar/Pages/TypeGrid.dart';
import 'package:bluecollar/Pages/WorkersPage.dart';
// import 'package:bluecollar/Pages/WorkersPageFuture.dart'

import 'package:bluecollar/Pages/debugscreen.dart';
import 'package:bluecollar/Pages/editprofilehirer.dart';
import 'package:bluecollar/Pages/editprofileworker.dart';
import 'package:bluecollar/Pages/hirerRequestpage.dart';
import 'package:bluecollar/Pages/page_Landing.dart';
import 'package:bluecollar/Pages/page_Login.dart';
import 'package:bluecollar/Pages/pg_Landing2.dart';
import 'package:bluecollar/Pages/pg_OTP_Hirer.dart';
import 'package:bluecollar/Pages/pg_verifyLogin.dart';
import 'package:bluecollar/Pages/page_Role.dart';
import 'package:bluecollar/Pages/page_signup.dart';
import 'package:bluecollar/Pages/page_workerinfo.dart';
import 'package:bluecollar/Pages/pg_registration.dart';
import 'package:bluecollar/Pages/pg_registration2.dart';
import 'package:bluecollar/Pages/pg_favourites.dart';
import 'package:bluecollar/Pages/receivedRequests.dart';
import 'package:bluecollar/Pages/worker_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Page_Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        print("case1");
        return MaterialPageRoute(builder: (context) => debugScreen());

      case '/Signup':
        return MaterialPageRoute(builder: (context) => SignUp());

      case '/Register_Worker':
        print("case2");
        return MaterialPageRoute(builder: (context) => const pg_registration());
      case '/Register_Hirer':
        print("caseHirer");
        return MaterialPageRoute(builder: (context) => pg_registration2());

        // case '/fetch':
        //   final args = settings.arguments as List<String>;
        //   return MaterialPageRoute(
        //       builder: (context) => WorkersPage(
        //             category: args[0],
        //           ));
        // case '/fetchFuture':
        //   print("case2");
        //   return MaterialPageRoute(
        //       builder: (context) => WorkersPageFuture(
        //             category: "WatchMen",
        //           ));

        // return MaterialPageRoute(builder: (context) => page_Landing());
        break;

      case '/Login':
        return MaterialPageRoute(builder: (context) => page_Login());
      case '/Primary_Login':
        final args = settings.arguments as List<int>;
        return MaterialPageRoute(
            builder: (context) => pg_verifyLogin(loginflag: args[0]));
      case '/OTP':
        return MaterialPageRoute(builder: (context) => OTPScreen());
      case '/Primary_OTP':
        return MaterialPageRoute(builder: (context) => pg_OTP_Hirer());
      case '/Home':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomeScreen(),
            transitionDuration: Duration(seconds: 3));

      case '/Role':
        return MaterialPageRoute(builder: (context) => page_Role());
      case '/workerprofile':
        final args = settings.arguments as List<dynamic>;
        // DocumentSnapshot dc = DocumentSnapshot();
        return MaterialPageRoute(
            builder: (context) => page_workerinfo(
                  ds: args[0],
                  favs: args[1],
                ));

      case '/workerPage':
        // if (settings.arguments == null) {
        //   print("null");
        //   return PageRouteBuilder(
        //       pageBuilder: (_, __, ___) => WorkersPage(category: "args[0]"),
        //       transitionDuration: Duration(seconds: 3));
        // } else {
        //   final args = settings.arguments as List<String>;
        //   return PageRouteBuilder(
        //       pageBuilder: (_, __, ___) => WorkersPage(category: args[0]),
        //       transitionDuration: Duration(seconds: 3));
        // }
        if (settings.arguments == null) {
          print("null");
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => WorkersPage(category: "args[0]"),
              transitionDuration: Duration(seconds: 3));
        } else {
          final args = settings.arguments as List<String>;
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => WorkersPage(category: args[0]),
              transitionDuration: Duration(seconds: 3));
        }

      // } else {
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => WorkersPage(category: args[0]),
      //       transitionDuration: Duration(seconds: 3));
      // }
      // transitionsBuilder: (_, a, __, c) => ,
      // return MaterialPageRoute(
      //     builder: (context) => WorkersPage(category: "WatchMen"));
      case '/TypeGrid':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => TypeGrid(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );

      // MaterialPageRoute(builder: (context) => const TypeGrid());

      case '/favourites':
        // return
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => pg_favourites(),
          transitionDuration: Duration(seconds: 2),
        );
      case '/Received':
        // return
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => receivedRequests(),
          transitionDuration: Duration(seconds: 2),
        );

      case '/Requests':
        // return
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => hirerRequest(),
          transitionDuration: Duration(seconds: 2),
        );

      case '/editHirer':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => editprofilehirer(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );
      case '/editWorker':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => editprofileworker(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );

      case '/workerHome':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => worker_homepage(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );

      case '/workerEdit':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => editprofileworker(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );
      case '/landing':
        final args = settings.arguments as List<String?>;
        print("Current user is :" + args[0].toString());
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => page_Landing2(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );
      case '/landing1':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => page_Landing(),
          transitionDuration: Duration(seconds: 3),
          // transitionsBuilder: (_, a, __, c) => ,
        );
      default:
        return MaterialPageRoute(
            builder: (context) => const Text("Encountered Some Error !"));
    }
  }
}
