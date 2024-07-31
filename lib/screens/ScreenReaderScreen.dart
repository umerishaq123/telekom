////
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/image_to_text.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:http/http.dart' as http;

class ScreenReaderScreen extends StatefulWidget {
  const ScreenReaderScreen({Key? key}) : super(key: key);

  @override
  _ScreenReaderScreenState createState() => _ScreenReaderScreenState();
}

class _ScreenReaderScreenState extends State<ScreenReaderScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  Future<ImagetotextModel>? viewimagetotextinfo;
  @override
  void dispose() {
    // Dispose resources here
    flutterTts.speak('');
    flutterTts.stop(); // Stop any ongoing speech
    super.dispose();
  }

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

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      setState(() {
        isPlaying = true;
      });
      await flutterTts.speak(text);
    } catch (e) {
      print("Error while speaking: $e");
    }
  }

  Future<void> _pause() async {
    await flutterTts.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ImageToTextProvider>(context);

    return PopScope(
      onPopInvoked: (bool didPop) {
        didPop ? _resetState : SizedBox();
        // Handle the pop. If `didPop` is false, it was blocked.
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Text Reader",
            style: TextStyle(fontSize: 18),
          ),
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
                  child: Builder(builder: (context) {
                    return Consumer<ImageToTextProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return ElevatedButton(
                          onPressed:
                              provider.isLoading || provider.imageToText == null
                                  ? null
                                  : () {
                                      print(
                                          ":::: the text shown above is :${provider.imageToText!.extractedText!}");
                                      String text =
                                          provider.imageToText!.extractedText!;
                                      _speak(text);
                                    },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colorpath.buttonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (!value.isLoading)
                                  const Text(
                                    "Convert",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                if (value.isLoading)
                                  (CircularProgressIndicator())
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isPlaying) {
                        _pause();
                      } else {
                        if (provider.imageToText?.extractedText != null) {
                          String text = provider.imageToText!.extractedText!;
                          _speak(text);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colorpath.buttonColor2),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      child: Text(
                        "Play",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      // _showAlertDialog(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Imagetotext(),
                          ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colorpath.buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      child: Text(
                        "Read",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetState() {
    setState(() {
      _selectedImage = null;
      isPlaying = false;
      // Clear text in provider
      Provider.of<ImageToTextProvider>(context, listen: false).clearText();
    });
  }

//  void _showAlertDialog(BuildContext context) {
//     showDialog(

//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Center(child: Text('Read')),
//           content: Consumer<ImageToTextProvider>(
//             builder: (BuildContext context, value, Widget? child) {
//               if (value.isLoading) {
//                 return CircularProgressIndicator();
//               } else {
//                 final extractedText = value.imageToText?.extractedText ?? 'No text found';
//                 return Center(child: Text(extractedText));
//               }
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

  // Future<String> _fetchTextFromUrl(String url) async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       throw Exception('Failed to load text from URL');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load text from URL: $e');
  //   }
  // }
}
