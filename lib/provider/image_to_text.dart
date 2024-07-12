import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';

import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

class ImageToTextProvider with ChangeNotifier {
  Imagetotext? _imageToText;

  Imagetotext? get imageToText => _imageToText;

  Future<void> processImage(File image) async {
    final token = await SessionHandlingViewModel().getToken();
    final url = Uri.parse(Apiurl.imagetotext);
    print("::: the image pthe is hare:${image.path.toString()}");
    final request =await http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Token $token'
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await request.send();
    print("::: the response is :${response}");
        print("::: the response is :${response.statusCode}");

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);
      _imageToText = Imagetotext.fromJson(jsonResponse);
      notifyListeners();
    } else {
      throw Exception('Failed to process image');
    }
  }
}
