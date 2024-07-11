import 'package:flutter/material.dart';
import 'package:telkom/utils/ColorPath.dart';

class ScreenReaderScreen extends StatelessWidget {
  const ScreenReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Google lens"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 15),
        alignment: Alignment.center,
        child: Column(

          children: [
            const SizedBox(height: 30,),

            const Image(image: AssetImage("assets/lens.png")),

            const SizedBox(height: 50,),

            SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colorpath.buttonColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    child: Text(
                      "Voice Converted Note",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Colorpath.buttonColor2),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    child: Text(
                      "Text Converted Note",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
