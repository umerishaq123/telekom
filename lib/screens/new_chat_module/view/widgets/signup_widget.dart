

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telekom2/main.dart';
import 'package:telekom2/provider/firebase_provider.dart';
import 'package:telekom2/screens/new_chat_module/service/firebase_firestore_service.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/login_widget.dart';
import 'package:telekom2/utils/ColorPath.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> obscureText = ValueNotifier(true);

    final registerProvider =
        Provider.of<FirebaseProvider>(context, listen: false);
    return Scaffold(
      
      appBar: AppBar(
      
        title:Text('Sign Up now',style: TextStyle(fontSize: 24),),
      centerTitle: true,),
      
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter first name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter last name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      !EmailValidator.validate(value!) ? 'Invalid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 16),
                Builder(builder: (context) {
                  return Consumer<FirebaseProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return ElevatedButton(
                              onPressed:value.isLoading? null: _signUp,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: Colorpath.cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child:  Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (!value.isLoading)
                                    const Text(
                                      "Signup",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  if (value.isLoading)
                                    (CircularProgressIndicator())
                                ],
                              ),
                            );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    

    final username = _usernameController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // API call to register user
    try {
      final apiService = FirebaseProvider(); // Initialize your API service

      // Check API response and handle accordingly

      // Display a progress indicator dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      try {
        apiService
            .registerApi(
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        )
            .then((value) {
          // Create user profile in Firestore
          FirebaseFirestoreService.createUser(
            image:
                'https://firebasestorage.googleapis.com/v0/b/telekom-f3eb5.appspot.com/o/avatar-15.png?alt=media&token=43173581-102e-4663-8097-d38b78559b75',
            email: email,
            uid: email,
            username: username,
            firstname: firstName,
            lastname: lastName,
            password: password,
            confirmpassword: confirmPassword,
          );
        });

        // Clear form fields
        _usernameController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginWidget(
                    onClickedSignUp: toggle,
                  )),
        );
      } catch (e) {
        // Handle other exceptions (e.g., network issues, server errors)
        // Show generic error message to the user
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Registration sucessfully..'),
        //   ),
        // );
        print("::: the error is :${e.toString()}");
      }


      // Handle API registration failure
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('API registration sucessfully. .'),
      //   ),
      // );
    } catch (e) {
      // Handle API call exceptions
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('API call failed. Please try again.'),
      //   ),
      // );
    }
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
