
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom/screens/MapScreen.dart';
import 'package:telkom/screens/NotesScreen.dart';
import 'package:telkom/screens/ScreenReaderScreen.dart';
import 'package:telkom/utils/ColorPath.dart';
import 'package:telkom/utils/ImathPaths.dart';

import '../../navigations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 37,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image(image: AssetImage(ImagePaths.women)),
          ),


           const SizedBox(height: 20,)
,           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(




               crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                GestureDetector(
                  onTap: ()=> Get.to(const ScreenReaderScreen()),

                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
                    width: 135,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colorpath.cardColor ,
                        borderRadius: BorderRadius.circular(10)
                    ),
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

                              SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("SCREEN READER" ,style: TextStyle(color: Colors.white ,fontSize: 14 ,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  
                  onTap: ()=> Get.to(const MapScreen()),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 0 ,horizontal: 10),
                    width: 140,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colorpath.cardColor ,
                        borderRadius: BorderRadius.circular(10)
                    ),
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
                              SizedBox(height: 10,),
                  
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("GEOTAGGING" ,style: TextStyle(color: Colors.white ,fontSize: 14 ,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
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

              onTap:  ()=> Get.to(()=>const NavigationMenu()),

                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colorpath.cardColor ,
                      borderRadius: BorderRadius.circular(10)
                  ),
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
                            SizedBox(height: 10,),

                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text("BUDDY CONNECTOR" ,style: TextStyle(color: Colors.white ,fontSize: 14 ,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=> Get.to(const NotesScreen()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colorpath.cardColor ,
                      borderRadius: BorderRadius.circular(10)
                  ),
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
                              child: Text("Voice Notes \nVoice & Braille Code" ,style: TextStyle(color: Colors.white ,fontSize: 14 ,fontWeight: FontWeight.w400  ,), textAlign: TextAlign.center,),
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
