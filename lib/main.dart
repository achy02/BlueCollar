import 'package:bluecollar/Utils/Page_Router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';

// void main() {
// }

Future<void> main() async {
  // bool shouldUseFirebaseEmulator = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   // Set androidProvider to `AndroidProvider.debug`
  //   androidProvider: AndroidProvider.debug,
  // );

  // FirebaseAuth.instance.setSettings(
  //   appVerificationDisabledForTesting: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlueCollar',
      onGenerateRoute: Page_Router.generateRoute,
      // routes: {
      //   '/': (context) => page_Landing(),
      //   '/Signup': (context) => const SignUp()
      // },
      initialRoute: '/',
    );
  }
}
