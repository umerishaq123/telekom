// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:telekom2/utils/ColorPath.dart';

// import '../homescreeen/HomeScreen.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 80,
//                 ),

//                 Text(
//                   "Sign Up now",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                       // fontFamily: GoogleFonts.aBeeZee().fontFamily,
//                       color: Colorpath.cardColor),
//                 ),

//                 SizedBox(
//                   height: 90,
//                 ),

//                 //email
//                 TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: "name",
//                     prefixIcon: Icon(Icons.person),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(
//                           color: Colorpath
//                               .cardColor), // Set color of unfocused border
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),

//                 TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: "number",
//                     prefixIcon: Icon(Icons.numbers),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(
//                           color: Colorpath
//                               .cardColor), // Set color of unfocused border
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 16,
//                 ),

//                 TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: "email",
//                     prefixIcon: Icon(Icons.email_outlined),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(
//                           color: Colorpath
//                               .cardColor), // Set color of unfocused border
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),

//                 TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: "password",
//                     prefixIcon: Icon(Icons.password),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(color: Colorpath.cardColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       borderSide: BorderSide(
//                           color: Colorpath
//                               .cardColor), // Set color of unfocused border
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 90,
//                 ),

//                 Container(
//                   width: 300,
//                   height: 40,
//                   decoration: const BoxDecoration(),
//                   child: ElevatedButton(
//                       onPressed: () => Get.to(HomeScreen()),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colorpath.cardColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16))),
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(color: Colors.white),
//                       )),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/models/signup_model.dart';
import 'package:telekom2/provider/signup_provider.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:telekom2/utils/apis_endpoints/apiurl.dart';
import 'package:telekom2/utils/utils.dart';
// Update with your correct path

import '../homescreeen/HomeScreen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Sign Up now",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      // fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      color: Colorpath.cardColor),
                ),
                SizedBox(
                  height: 90,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "username",
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: "last Name",
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "password",
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _confirmpasswordController,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colorpath.cardColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colorpath
                              .cardColor), // Set color of unfocused border
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);

                          final username = _usernameController.text;
                          final firstname = _firstNameController.text;
                          final lastname = _lastNameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final confirmpassword =
                              _confirmpasswordController.text;

                          await authProvider.registerApi(
                            username,
                            firstname,
                            lastname,
                            email,
                            password,
                            confirmpassword,
                          );

                          // Navigate to HomeScreen or perform other actions on success
                          // Get.to(HomeScreen());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorpath.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
