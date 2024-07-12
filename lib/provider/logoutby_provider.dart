import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'package:telekom2/utils/utils.dart';

class LogoutbyProvider with ChangeNotifier {
  Future<void> logout() async {
    try {
      // Fetch the current token and refresh token
      final token = await SessionHandlingViewModel().getToken();
      print("::: The token is here now: $token");

      // Define the API URL for logout
      final String apiUrl = Apiurl.logout;

      // Make the HTTP POST request to logout
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json', // Ensure the correct Content-Type
        },
      );

      print('::: The response of logout: ${response.body}');
      print('::: The status code of logout: ${response.statusCode}');

      if (response.statusCode == 204) {
        // Successful logout
        print('Logout successful');

        // Clear session data
        await SessionHandlingViewModel().removeUser();

        // Notify listeners that a change has occurred
        notifyListeners();
      } else if (response.statusCode == 200) {
        // Handle successful response with content (if expected)
        var responseData = jsonDecode(response.body);
        print('Logout successful: ${responseData["message"]}');
        final msg = responseData['message'];
        Utils.toastMessage('$msg');

        // Clear session data
        await SessionHandlingViewModel().removeUser();

        // Notify listeners that a change has occurred
        notifyListeners();
      } else {
        // Handle other error cases
        print('Failed to logout: ${response.statusCode}');
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error during logout: $e');
      throw Exception('Error during logout: $e');
    }
  }
}
