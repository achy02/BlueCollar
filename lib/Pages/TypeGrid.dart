import 'package:bluecollar/Utils/AppColors.dart';
import 'package:bluecollar/Widgets/BigText.dart';
import 'package:flutter/material.dart';

import '../Widgets/Bottom_NavBar.dart';

class TypeGrid extends StatefulWidget {
  const TypeGrid({super.key});
  static String Type_Selected = "";
  @override
  State<TypeGrid> createState() => _TypeGridState();
}

class _TypeGridState extends State<TypeGrid> {
  int _selectedElementIndex = -1;

  Widget GridElement(
      {required String image, required String name, required int index}) {
    final isSelected = index == _selectedElementIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedElementIndex = index;
          TypeGrid.Type_Selected = name;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: isSelected
                      ? Color.fromARGB(255, 146, 219, 255)
                      : Colors.blueGrey,
                  width: isSelected ? 4 : 2,
                ),
              ),
              child: null,
            ),
          ),
          BigText(
            text: name,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bottom_NavBar(indexx: 2),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 10),
                  child: Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 200, 226, 247),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/Home', (route) => false);
                            },
                          ),
                        ),
                        Container(
                          width: 300.0,
                          child: const Text(
                            "Worker Type",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Text(
                    "Select the category that you want  to hire .",
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 55),
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            child: GridView.count(
                              crossAxisCount: 2,
                              // scrollDirection: Axis.horizontal,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1.50,
                              children: [
                                GridElement(
                                    image: "assets/Images/Watchmen.png",
                                    name: "Watchmen",
                                    index: 0),
                                GridElement(
                                    image: "assets/Images/maid.png",
                                    name: "HouseHelp",
                                    index: 1),
                                GridElement(
                                    image: "assets/Images/Cook.png",
                                    name: "Cook",
                                    index: 2),
                                GridElement(
                                    image: "assets/Images/BusDriver.png",
                                    name: "BusDriver",
                                    index: 3),
                                GridElement(
                                    image: "assets/Images/CardDriver.png",
                                    name: "CarDriver",
                                    index: 4),
                                GridElement(
                                    image: "assets/Images/BabySitter.png",
                                    name: "Babysiter",
                                    index: 5),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 40,
              right: 40,
              bottom: 30,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: 50.0,
                child: SizedBox(
                  height: 70.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedElementIndex >= 0) {
                        Navigator.pushNamed(
                          context,
                          "/workerPage",
                          arguments: [TypeGrid.Type_Selected],
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            // const Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: Bottom_NavBar(
            //     indexx: 0,
            //   ),
            // ),
          ],
        ));
  }
}
