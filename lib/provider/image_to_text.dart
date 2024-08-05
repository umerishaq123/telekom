// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // import 'package:telekom2/provider/session_handling_provider.dart';
// // import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';

// // import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

// // class ImageToTextProvider with ChangeNotifier {
// //   bool _isLoading = false;
// //    String? extractedText;
// //     String _selectedLanguage = 'en'; // Default language (English)

// //   // Method to clear extractedText
// //   void clearText() {
// //     extractedText = null;
// //     notifyListeners(); // Notify listeners to update UI
// //   }

// //   bool get isLoading => _isLoading;

// //   setLoadingState(bool value) {
// //     _isLoading = value;
// //     notifyListeners();
// //   }
// //    void setLanguage(String languageCode) {
// //     _selectedLanguage = languageCode;
// //     notifyListeners();
// //   }

// //   ImagetotextModel? _imageToText;

// //   ImagetotextModel? get imageToText => _imageToText;
// // Future<void> processImage(File image) async {
// //     setLoadingState(true);

// //     try {
// //       final token = await SessionHandlingViewModel().getToken();
// //       final url = Uri.parse(Apiurl.imagetotext);

// //       final request = http.MultipartRequest('POST', url)
// //         ..headers['Authorization'] = 'Token $token'
// //         ..files.add(await http.MultipartFile.fromPath('image', image.path));

// //       final response = await request.send();
// // print(":::: the print status code is :${response.statusCode}");
// // // print(":::: the print status code is :${response.}");

// //       if (response.statusCode == 200) {
// //         final responseData = await response.stream.bytesToString();
// //         final jsonResponse = json.decode(responseData);
// //         _imageToText = ImagetotextModel.fromJson(jsonResponse);
// //         notifyListeners();
// //       } else {
// //         throw Exception('Failed to process image');
// //       }
// //     } catch (e) {
// //       print("Error processing image: $e");
// //       throw Exception('Failed to process image: $e');
// //     } finally {
// //       setLoadingState(false);
// //     }
// //   }

  
  
// //   }
  


  
//   import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:telekom2/provider/session_handling_provider.dart';
// import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';
// import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

// class ImageToTextProvider with ChangeNotifier {
//   bool _isLoading = false;
//   String? extractedText;
//   String _selectedLanguage = 'en'; // Default language (English)
//   File? _currentImage; // To store the currently selected image

//   bool get isLoading => _isLoading;

//   ImagetotextModel? _imageToText;

//   ImagetotextModel? get imageToText => _imageToText;

//   void clearText() {
//     extractedText = null;
//     notifyListeners(); // Notify listeners to update UI
//   }

//   setLoadingState(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void setLanguage(String languageCode) {
//     _selectedLanguage = languageCode;
//     if (_currentImage != null) {
//       processImage(_currentImage!); // Re-process the image with the new language
//     }
//     notifyListeners();
//   }

//   Future<void> processImage(File image) async {
//     _currentImage = image; // Store the currently selected image
//     setLoadingState(true);

//     try {
//       final token = await SessionHandlingViewModel().getToken();
//       final url = Uri.parse(Apiurl.imagetotext);

//       final request = http.MultipartRequest('POST', url)
//         ..headers['Authorization'] = 'Token $token'
//         ..fields['language'] = _selectedLanguage // Include selected language
//         ..files.add(await http.MultipartFile.fromPath('image', image.path));

//       final response = await request.send();
//       print(":::: the print status code is :${response.statusCode}");

//       if (response.statusCode == 200) {
//         final responseData = await response.stream.bytesToString();
//         final jsonResponse = json.decode(responseData);
//         _imageToText = ImagetotextModel.fromJson(jsonResponse);
//         extractedText = _imageToText?.extractedText;
//         notifyListeners();
//       } else {
//         throw Exception('Failed to process image');
//       }
//     } catch (e) {
//       print("Error processing image: $e");
//       throw Exception('Failed to process image: $e');
//     } finally {
//       setLoadingState(false);
//     }
//   }
// }





// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:telekom2/provider/session_handling_provider.dart';
// import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';
// import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

// class ImageToTextProvider with ChangeNotifier {
//   bool _isLoading = false;
//   String? _extractedText;
//   String _selectedLanguage = 'en'; // Default language (English)
//   File? _currentImage; // To store the currently selected image

//   bool get isLoading => _isLoading;
//   String get selectedLanguage => _selectedLanguage;
//   String? get extractedText => _extractedText;

//   ImagetotextModel? _imageToText;
//   ImagetotextModel? get imageToText => _imageToText;

//   void clearText() {
//     _extractedText = null;
//     notifyListeners(); // Notify listeners to update UI
//   }

//   void setLoadingState(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void setLanguage(String languageCode) {
//     _selectedLanguage = languageCode;
//     if (_currentImage != null) {
//       processImage(_currentImage!); // Re-process the image with the new language
//     }
//     notifyListeners();
//   }

//   Future<void> processImage(File image) async {
//     _currentImage = image; // Store the currently selected image
//     setLoadingState(true);

//     try {
//       final token = await SessionHandlingViewModel().getToken();
//       final url = Uri.parse(Apiurl.imagetotext);

//       final request = http.MultipartRequest('POST', url)
//         ..headers['Authorization'] = 'Token $token'
//         ..fields['language'] = _selectedLanguage // Include selected language
//         ..files.add(await http.MultipartFile.fromPath('image', image.path));

//       final response = await request.send();
//       print(":::: the print status code is :${response.statusCode}");

//       if (response.statusCode == 200) {
//         final responseData = await response.stream.bytesToString();
//         final jsonResponse = json.decode(responseData);
//         _imageToText = ImagetotextModel.fromJson(jsonResponse);
//         _extractedText = _imageToText?.extractedText;
//         notifyListeners();
//       } else {
//         throw Exception('Failed to process image');
//       }
//     } catch (e) {
//       print("Error processing image: $e");
//       throw Exception('Failed to process image: $e');
//     } finally {
//       setLoadingState(false);
//     }
//   }

//   @override
//   void dispose() {
//     clearText();
//     super.dispose();
//   }
// }



import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

class ImageToTextProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _extractedText;
  String _selectedLanguage = 'en'; // Default language (English)
  File? _currentImage; // To store the currently selected image

  bool get isLoading => _isLoading;
  String get selectedLanguage => _selectedLanguage;
  String? get extractedText => _extractedText;

  ImagetotextModel? _imageToText;
  ImagetotextModel? get imageToText => _imageToText;

  void clearText() {
    _extractedText = null;
    notifyListeners(); // Notify listeners to update UI
  }

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    if (_currentImage != null) {
      processImage(_currentImage!); // Re-process the image with the new language
    }
    notifyListeners();
  }

  Future<void> processImage(File image) async {
    _currentImage = image; // Store the currently selected image
    setLoadingState(true);

    try {
      final token = await SessionHandlingViewModel().getToken();
      final url = Uri.parse(Apiurl.imagetotext);

      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Token $token'
        ..fields['language'] = _selectedLanguage // Include selected language
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();
      print(":::: the print status code is :${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        _imageToText = ImagetotextModel.fromJson(jsonResponse);
        _extractedText = await translateText(_imageToText?.extractedText, _selectedLanguage);
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

  Future<String> translateText(String? text, String languageCode) async {
    // Implement the translation logic here. This is a mock implementation.
    // In real scenario, you would call an external translation service.
    if (text == null) return "";
    if (languageCode == 'ms') {
      return "Ini adalah teks contoh dari API"; // Translated text in Malay
    } else if (languageCode == 'id') {
      return "Ini adalah teks contoh dari API"; // Translated text in Indonesian
    } else {
      return text; // Default to original text
    }
  }

  // @override
  // void dispose() {
  //   clearText();
  //   super.dispose();
  // }
}
