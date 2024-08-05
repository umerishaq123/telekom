import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/main.dart';
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/homescreeen/HomeScreen.dart';
import 'package:telekom2/screens/new_chat_module/model/login_model.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'package:telekom2/utils/utils.dart';
import '../screens/new_chat_module/model/message.dart';
import '../screens/new_chat_module/model/user.dart';
import '../screens/new_chat_module/service/firebase_firestore_service.dart';
import 'package:http/http.dart' as http;

class FirebaseProvider extends ChangeNotifier {
   bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  ScrollController scrollController = ScrollController();

  List<UserModel> users = [];
  UserModel? user;
  List<Message> messages = [];
  List<UserModel> search = [];

  FirebaseProvider() {
    getAllUsers();
  }

  void getAllUsers() {
    
    print('::: calling all users');
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((usersSnapshot) {
      users = usersSnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
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
        .doc(GetMeEmail.senderId)
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
  Future<void> registerApi({required String username,required String firstName,required String lastName,
     required String email,required String password,required String confirmPassword,}) async {
        setLoadingState(true);
      notifyListeners();
    String apiUrl = Apiurl.signup; // Replace with your API endpoint

    try {
       _isLoading = true;
      notifyListeners();
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
        _isLoading = false;
      notifyListeners();
    }finally {
      setLoadingState(false);
      notifyListeners();
    }
  }



  //login
 Future<void> loginApi(String username, String password, BuildContext context) async {
    final sessionHandlingViewModel = Provider.of<SessionHandlingViewModel>(context, listen: false);
    String apiUrl = Apiurl.login; // Replace with your login API endpoint

    try {
        setLoadingState(true);
      notifyListeners();
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

      if (response.statusCode == 200) {
        final loginResponse = loginFromJson(response.body);
        final responseData = jsonDecode(response.body);
        final userToken = responseData['token'];
        print(':::: the token is here: $userToken');
         SessionHandlingViewModel().saveToken(userToken,);
Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
        print("::: the response of login API is: ${response.body}");
        print("::: the response code of login API is: ${response.statusCode}");

        // Successfully logged in
        Utils.toastMessage('Login successful');
        print('Login successful');

        // Handle further logic after successful login, such as navigating to another screen
      } else {
        // Login failed
        Utils.toastMessage('Login failed');
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      // Exception occurred during login
      Utils.toastMessage('Login failed: $e');
      print('Login failed: $e');
    }finally {
      setLoadingState(false);
    }
  }
}
