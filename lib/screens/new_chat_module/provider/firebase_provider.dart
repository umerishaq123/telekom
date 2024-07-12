import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'package:telekom2/utils/utils.dart';
import '../model/message.dart';
import '../model/user.dart';
import '../service/firebase_firestore_service.dart';
import 'package:http/http.dart' as http;

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<UserModel> users = [];
  UserModel? user;
  List<Message> messages = [];
  List<UserModel> search = [];

  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users = users.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages = messages.docs
          .map((doc) => Message.fromJson(doc.data()))
          .toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
              scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search =
        await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }





  ///auth
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
   Future<void> loginApi(String username, String password) async {
    String apiUrl = Apiurl.login; // Replace with your login API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
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
