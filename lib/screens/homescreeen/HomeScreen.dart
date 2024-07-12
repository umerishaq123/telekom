import 'package:flutter/material.dart';

import 'package:telekom2/screens/NotesScreen.dart';
import 'package:telekom2/screens/ScreenReaderScreen.dart';
import 'package:telekom2/screens/new_chat_module/view/screens/chats_screen.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:telekom2/utils/ImathPaths.dart';
import 'package:telekom2/utils/drawer.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: TeacherDrawerWidget(height: height,),
      body: Column(
        children: [
          const SizedBox(
            height: 37,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image(image: AssetImage(ImagePaths.women)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenReaderScreen(),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: 135,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colorpath.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(ImagePaths.screenreader),
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "SCREEN READER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const MapScreen(),
                    //     ));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    width: 140,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colorpath.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(ImagePaths.geo),
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "GEOTAGGING",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                // onTap: ()=> Get.to(BuddyConnectorScreen()),

                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatsScreen(),
                      ));
                },

                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colorpath.cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(ImagePaths.buddy),
                              width: 48,
                              height: 48,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "BUDDY CONNECTOR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesScreen(),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colorpath.cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(ImagePaths.voice),
                              width: 48,
                              height: 48,
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Voice Notes \nVoice & Braille Code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
