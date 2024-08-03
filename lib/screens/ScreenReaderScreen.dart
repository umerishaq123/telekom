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
  bool isProcessing = false;
  int processingPercentage = 0;
  Future<ImagetotextModel>? viewimagetotextinfo;

   @override
  void dispose() {
    flutterTts.stop();
    _resetState();
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
      setState(() {
        isProcessing = true;
        processingPercentage = 0;
      });

      // Simulate image processing and updating progress
      for (int i = 0; i <= 100; i++) {
        await Future.delayed(Duration(milliseconds: 50));
        setState(() {
          processingPercentage = i;
        });
      }

      try {
        await Provider.of<ImageToTextProvider>(context, listen: false)
            .processImage(_selectedImage!);

        setState(() {
          isProcessing = false;
        });

      } catch (error) {
        setState(() {
          isProcessing = false;
        });
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

    return Scaffold(
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
              const SizedBox(height: 30),
              if (isProcessing) ...[
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        minHeight: 25,
                        value: processingPercentage / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colorpath.buttonColor2),
                      ),
                      const SizedBox(height: 10),
                      Text('$processingPercentage%'),
                    ],
                  ),
                ),
              ] else if (provider.imageToText != null) ...[
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
                    child:  Padding(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      child:isPlaying? Icon(Icons.pause_circle_outlined,size: 35,):Icon(Icons.play_circle_outline_outlined,size: 35,)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
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
              ]
            ],
          ),
        ),
      ),
    );
  }

  // void _resetState() {
  //   setState(() {
  //     _selectedImage = null;
  //     isPlaying = false;
  //     // Clear text in provider
  //     Provider.of<ImageToTextProvider>(context, listen: false).clearText();
  //   });
  // }
  void _resetState() {
    setState(() {
      _selectedImage = null;
      isPlaying = false;
      isProcessing = false;
      processingPercentage = 0;
        Provider.of<ImageToTextProvider>(context, listen: false).clearText();
    });
  }
}





