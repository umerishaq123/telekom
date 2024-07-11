import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'package:telekom2/utils/utils.dart';

class AuthProvider with ChangeNotifier {
  Future<void> registerApi(String username, String firstName, String lastName,
      String email, String password, String confirmPassword) async {
    String apiUrl = Apiurl.signup; // Replace with your API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
          "password2": confirmPassword
        }),
      );

      print("::: the response of api is :${response.body}");
      print("::: the response of api is :${response.statusCode}");

      if (response.statusCode == 201) {
        // Successfully registered
        Utils.toastMessage('Registration successful');
        print('Registration successful');
      } else {
        // Registration failed
        Utils.toastMessage('Registration failed: ${response.body}');
        print('Registration failed: ${response.body}');
      }
    } catch (e) {
      // Exception occurred during registration
      Utils.toastMessage('Registration failed: $e');
      print('Registration failed: $e');
    }
  }



  //login
   Future<void> loginApi(String email, String password) async {
    String apiUrl = Apiurl.login; // Replace with your login API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": email,
          "password": password,
        }),
      );

      print("::: the response of login api is :${response.body}");
      print("::: the response code of login api is :${response.statusCode}");

      if (response.statusCode == 200) {
        // Successfully logged in
        Utils.toastMessage('Login successful');
        print('Login successful');

        // Handle further logic after successful login, such as storing tokens or navigating to another screen
      } else {
        // Login failed
        Utils.toastMessage('Login failed: ${response.body}');
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      // Exception occurred during login
      Utils.toastMessage('Login failed: $e');
      print('Login failed: $e');
    }
  }
}
