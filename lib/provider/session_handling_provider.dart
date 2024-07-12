import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SessionHandlingViewModel with ChangeNotifier {
  Future<bool> saveToken(String token, role) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('token', token);
      await sp.setString('role', role);
      notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving token: $e');
      return false; // Token not saved
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    notifyListeners();
    return token;
  }

  Future removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    notifyListeners();
    return sp.clear();
  }
}
