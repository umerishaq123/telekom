// import 'package:flutter/material.dart';
// import 'package:telekom2/utils/ColorPath.dart';

// class ScreenReaderScreen extends StatelessWidget {
//   const ScreenReaderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text("Google lens"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.more_vert),
//           )
//         ],
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 15),
//         alignment: Alignment.center,
//         child: Column(

//           children: [
//             const SizedBox(height: 30,),

//             const Image(image: AssetImage("assets/lens.png")),

//             const SizedBox(height: 50,),

//             SizedBox(
//               width: screenWidth * 0.9,
//               child: ElevatedButton(
//                   onPressed: () {},
//                   style: ButtonStyle(
//                     backgroundColor:
//                         WidgetStateProperty.all<Color>(Colorpath.buttonColor),
//                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.only(top: 13, bottom: 13),
//                     child: Text(
//                       "Voice Converted Note",
//                       style: TextStyle(color: Colors.black, fontSize: 20),
//                     ),
//                   )),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: screenWidth * 0.9,
//               child: ElevatedButton(
//                   onPressed: () {},
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all<Color>(
//                         Colorpath.buttonColor2),
//                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.only(top: 13, bottom: 13),
//                     child: Text(
//                       "Text Converted Note",
//                       style: TextStyle(color: Colors.black, fontSize: 20),
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/utils/ColorPath.dart';

class ScreenReaderScreen extends StatefulWidget {
  const ScreenReaderScreen({super.key});

  @override
  _ScreenReaderScreenState createState() => _ScreenReaderScreenState();
}

class _ScreenReaderScreenState extends State<ScreenReaderScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  FlutterTts flutterTts = FlutterTts();
  // Replace with your token

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_selectedImage != null) {
      try {
        await Provider.of<ImageToTextProvider>(context, listen: false)
            .processImage(
          _selectedImage!,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _speak(List<String> texts) async {
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      for (String text in texts) {
        await flutterTts.speak(text);
      }
    } catch (e) {
      print("Error while speaking: $e");
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ImageToTextProvider>(context);

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: SizedBox(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  child: _selectedImage == null
                      ? const Image(image: AssetImage("assets/lens.png"))
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: ElevatedButton(
                    onPressed: () {
                      print(
                          "::: the text is printed:${provider.imageToText!.extractedText!}");
                      if (provider.imageToText?.extractedText != null) {
                        List<String> texts = [
                          provider.imageToText!.extractedText!
                        ];
                        _speak(texts);
                      }
                    },
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
      ),
    );
  }
}
