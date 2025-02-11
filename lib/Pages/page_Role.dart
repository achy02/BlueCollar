import 'package:bluecollar/Utils/AppColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Widgets/BigText.dart';

class page_Role extends StatefulWidget {
  static bool role = true; //false==worker, true==Hirer
  const page_Role({super.key});

  @override
  State<page_Role> createState() => _page_RoleState();
}

class _page_RoleState extends State<page_Role> {
  Widget GridElement(
      {required String Image, required String name, required int height}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: AppColors.RoleColor, width: 2),
          color: AppColors.RoleColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height.toDouble(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Image),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: BigText(
                text: name,
                ff: 'Roboto',
                fw: FontWeight.bold,
                size: 21,
                colorr: Color.fromARGB(255, 0, 0, 0),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Container(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BigText(
                    text: "BlueCollar",
                    fw: FontWeight.bold,
                    ff: 'Playfair',
                    size: 55,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 7),
                child: BigText(
                  text: "Making blue-collar hiring hassle-free",
                  size: 21.5,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 7.9),
                        child: BigText(
                          text: "Who are You?",
                          size: 30,
                          fw: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Container(
                          height: 300,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.05,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.RoleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    elevation: 0.0,
                                    side: const BorderSide(
                                        color: AppColors.RoleColor)),
                                onPressed: () {
                                  page_Role.role = true;
                                  Navigator.pushNamed(
                                    context,
                                    "/Signup",
                                  );
                                  print("pressed");
                                },
                                child: GridElement(
                                    Image: "assets/Images/recruitment.png",
                                    name: "Recruiter",
                                    height: 80),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.RoleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    elevation: 0.0,
                                    side: const BorderSide(
                                        color: AppColors.RoleColor)),
                                onPressed: () {
                                  setState(() {
                                    page_Role.role = false;
                                  });
                                  Navigator.pushNamed(context, "/Primary_Login",
                                      arguments: [0]);
                                },
                                child: GridElement(
                                    Image: "assets/Images/workerss.png",
                                    height: 88,
                                    name: "Workers"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          )),
    );
  }
}
