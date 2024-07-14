import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';

import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

class ImageToTextProvider with ChangeNotifier {
  bool _isLoading = false;
   String? extractedText;

  // Method to clear extractedText
  void clearText() {
    extractedText = null;
    notifyListeners(); // Notify listeners to update UI
  }

  bool get isLoading => _isLoading;

  setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ImagetotextModel? _imageToText;

  ImagetotextModel? get imageToText => _imageToText;
Future<void> processImage(File image) async {
    setLoadingState(true);

    try {
      final token = await SessionHandlingViewModel().getToken();
      final url = Uri.parse(Apiurl.imagetotext);

      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Token $token'
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        _imageToText = ImagetotextModel.fromJson(jsonResponse);
        notifyListeners();
      } else {
        throw Exception('Failed to process image');
      }
    } catch (e) {
      print("Error processing image: $e");
      throw Exception('Failed to process image: $e');
    } finally {
      setLoadingState(false);
    }
  }

  
//   Future<void> processImage(File image) async {
//     setLoadingState(true);
//     final token = await SessionHandlingViewModel().getToken();
//     final url = Uri.parse(Apiurl.imagetotext);
//   try{
// final request =await http.MultipartRequest('POST', url)
//       ..headers['Authorization'] = 'Token $token'
//       ..files.add(await http.MultipartFile.fromPath('image', image.path));

//     final response = await request.send();
//     print("::: the response is :${response}");
//         print("::: the response is :${response.statusCode}");

//     if (response.statusCode == 200) {
//       final responseData = await response.stream.bytesToString();
//       final jsonResponse = json.decode(responseData);
//       _imageToText = ImagetotextModel.fromJson(jsonResponse);
//       final text=jsonResponse['extracted_text'];
//       final texturl=jsonResponse['textUrl'];
//       print("::: the text in provider is hsre:$text");
//         print("::: the text in provider isurl hsre:$texturl");
//       notifyListeners();
//     } else {
//       throw Exception('Failed to process image');
//     }
//     setLoadingState(false);
//   }
  
//   catch(e){
// print("::: the error of text to image :${e.toString()}");
//   }
    
//   }
  
  }
  