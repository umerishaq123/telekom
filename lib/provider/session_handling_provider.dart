import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHandlingViewModel with ChangeNotifier {
   String? _token;
  DateTime? _tokenExpiry;
  // Method to save token
  Future<bool> saveToken(var token) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('token', token);
      notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving token: $e');
      return false; // Token not saved
    }
  }

  // Method to get token
  Future<String?> getToken() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? token = sp.getString('token');
      print("::: the token is here in session : $token");
      notifyListeners();
      return token;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }
Future<void> refreshToken() async {
    // Example logic to refresh token
    try {
      // Call your token refresh API
      // Update _token and _tokenExpiry based on the refreshed token
    } catch (e) {
      print('Error refreshing token: $e');
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> removeUser() async {
    // Clear session data, including token
    _token = null;
    _tokenExpiry = null;
    // Implement logic to clear any other user-related data
  }
}
