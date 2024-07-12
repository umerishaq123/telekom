import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'dart:convert';


class NotesProvider extends ChangeNotifier {
  //  SessionHandlingViewModel() sessionHandlingViewModel=SessionHandlingViewModel();
  List<Listoflecture> _lectures = [];

  List<Listoflecture> get lectures => _lectures;
Future<List<Listoflecture>> fetchApiData() async {
  final token = await SessionHandlingViewModel().getToken();
  print("::: the token is here now: $token");
  String apiUrl = Apiurl.listoflectures;

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    print("::: the response of body is :${response.body}");
    print("::: the response of statuscode is :${response.statusCode}");

    if (response.statusCode == 200) {
      final List<dynamic> parsedJson = jsonDecode(response.body);
      List<Listoflecture> fetchedLectures = parsedJson.map((json) => Listoflecture.fromJson(json)).toList();
      _lectures = fetchedLectures; // Update the _lectures list
      notifyListeners(); // Notify listeners to update UI
      return fetchedLectures;
    } else {
      print('Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Error fetching data: $e');
  }
}


}
