// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:telekom2/provider/session_handling_provider.dart';
// import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart';
// import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
// import 'dart:convert';

// class NotesProvider extends ChangeNotifier {
//   List<Listoflecture> _lectures = [];
//   List<String> _audioFiles = [];

//   List<Listoflecture> get lectures => _lectures;
//   List<String> get audioFiles => _audioFiles;
//   void addAudioFile(String filePath) {
//     // Extract the file name from the path
//     final fileName = filePath.split('/').last;

//     // Determine the file type
//     final fileType =
//         filePath.toLowerCase().endsWith('.pdf') ? 'PDF Document' : 'Audio';

//     // Create a new Listoflecture instance with the file name and type
//     _lectures.add(Listoflecture(
//       fileUrl: filePath,
//       details: '$fileName ($fileType)',
//     ));

//     // Notify listeners to update the UI
//     notifyListeners();
//   }

//   Future<List<Listoflecture>> fetchApiData() async {
//     final token = await SessionHandlingViewModel().getToken();
//     print("::: the token is here now: $token");
//     String apiUrl = Apiurl.listoflectures;

//     try {
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Token $token',
//         },
//       );

//       print("::: the response of body is :${response.body}");
//       print("::: the response of statuscode is :${response.statusCode}");

//       if (response.statusCode == 200) {
//         final List<dynamic> parsedJson = jsonDecode(response.body);
//         List<Listoflecture> fetchedLectures =
//             parsedJson.map((json) => Listoflecture.fromJson(json)).toList();
//         _lectures = fetchedLectures; // Update the _lectures list
//         notifyListeners(); // Notify listeners to update UI
//         return fetchedLectures;
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       throw Exception('Error fetching data: $e');
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';

class NotesProvider extends ChangeNotifier {
  bool _isLoading = false;
    bool get isLoading => _isLoading;
  List<Listoflecture> _lectures = [];
  List<String> _audioFiles = [];
   void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Listoflecture> get lectures => _lectures;
  List<String> get audioFiles => _audioFiles;

  Future<void> fetchApiData() async {
    setLoadingState(true);
    notifyListeners();
    final token = await SessionHandlingViewModel().getToken();
    String apiUrl = Apiurl.listoflectures;

    try {
      // Fetch data from API
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> parsedJson = jsonDecode(response.body);
        List<Listoflecture> apiLectures =
            parsedJson.map((json) => Listoflecture.fromJson(json)).toList();

        // Fetch local files from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? localFiles = prefs.getStringList('localFiles') ?? [];

        List<Listoflecture> localLectures = localFiles
            .map((file) => Listoflecture(
                  details: file.split('/').last,
                  fileUrl: file,
                ))
            .toList();

        // Merge data
        _lectures = [...apiLectures, ...localLectures];
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    } finally {
      setLoadingState(false);
      notifyListeners();
    }
  }

  void addAudioFile(String filePath) async {
    // Add to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? localFiles = prefs.getStringList('localFiles') ?? [];
    localFiles.add(filePath);
    await prefs.setStringList('localFiles', localFiles);

    // Add to the list and notify listeners
    final fileName = filePath.split('/').last;
    final fileType =
        filePath.toLowerCase().endsWith('.pdf') ? 'PDF Document' : 'Audio';

    _lectures.add(Listoflecture(
      fileUrl: filePath,
      details: '$fileName ($fileType)',
    ));
    notifyListeners();
  }
    void deleteLecture(int index) {
    _lectures.removeAt(index);
    notifyListeners();
  }
}
