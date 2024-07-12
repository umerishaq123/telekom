// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // import 'package:telekom2/screens/authentication/ForgotScreen.dart';
// // import 'package:telekom2/screens/homescreeen/HomeScreen.dart';

// // import '../../utils/ColorPath.dart';
// // import 'SignUpScreen.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Container(
// //           alignment: Alignment.center,
// //           margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
// //           child: Form(
// //               child: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 16),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 SizedBox(
// //                   height: 110,
// //                 ),

// //                 Text(
// //                   "Sign In now",
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.w700,
// //                       fontSize: 18,
// //                       // fontFamily: GoogleFonts.aBeeZee().fontFamily,
// //                       color: Colorpath.cardColor),
// //                 ),

// //                 SizedBox(
// //                   height: 80,
// //                 ),
// //                 //email
// //                 TextFormField(
// //                   expands: false,
// //                   decoration: const InputDecoration(
// //                     labelText: "gmail",
// //                     prefixIcon: Icon(Icons.email),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       borderSide: BorderSide(color: Colorpath.cardColor),
// //                     ),
// //                     enabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       borderSide: BorderSide(
// //                           color: Colorpath
// //                               .cardColor), // Set color of unfocused border
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(
// //                   height: 20,
// //                 ),

// //                 TextFormField(
// //                   expands: false,
// //                   decoration: const InputDecoration(
// //                     labelText: "password",
// //                     prefixIcon: Icon(Icons.remove_red_eye),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       borderSide: BorderSide(color: Colorpath.cardColor),
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       borderSide: BorderSide(color: Colorpath.cardColor),
// //                     ),
// //                     enabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       borderSide: BorderSide(
// //                           color: Colorpath
// //                               .cardColor), // Set color of unfocused border
// //                     ),
// //                   ),
// //                 ),

// //                 Align(
// //                   alignment: Alignment.topRight,
// //                   child: TextButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => const ForgotScreen(),
// //                             ));
// //                       },
// //                       child: const Text(
// //                         "Forgot Password",
// //                         style: TextStyle(
// //                             color: Colorpath.cardColor,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.w400),
// //                       )),
// //                 ),

// //                 SizedBox(
// //                   height: 60,
// //                 ),
// //                 Container(
// //                   width: 300,
// //                   height: 40,
// //                   decoration: const BoxDecoration(),
// //                   child: ElevatedButton(
// //                       onPressed: () {
                        
// //                         Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => const HomeScreen(),
// //                             ));
// //                       },
// //                       //Get.to(HomeScreen()),
// //                       style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colorpath.cardColor,
// //                           shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(16))),
// //                       child:const Text(
// //                         "Log In",
// //                         style: TextStyle(color: Colors.white),
// //                       )),
// //                 ),
// //                 SizedBox(
// //                   height: 40,
// //                 ),

// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Text(
// //                       "Don't have an account?",
// //                       style: TextStyle(fontSize: 14),
// //                     ),
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => const SignUpScreen(),
// //                             ));
// //                       },
// //                       style: ButtonStyle(
// //                         padding: MaterialStateProperty.all(EdgeInsets.zero),
// //                       ),
// //                       child: const Text(
// //                         "Sign up",
// //                         style: TextStyle(color: Colorpath.cardColor),
// //                       ),
// //                     )
// //                   ],
// //                 )
// //               ],
// //             ),
// //           )),
// //         ),
// //       ),
// //     );
// //   }
// // }
// /////
// ///
// ///
// ///
// ///
// ///
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// import 'package:telekom2/screens/authentication/ForgotScreen.dart';
// import 'package:telekom2/screens/homescreeen/HomeScreen.dart';

// import '../../utils/ColorPath.dart';
// import 'SignUpScreen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authProviderlogin = Provider.of<AuthProvider>(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//           child: Form(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 110),
//                   Text(
//                     "Sign In now",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                       color: Colorpath.cardColor,
//                     ),
//                   ),
//                   SizedBox(height: 80),
//                   TextFormField(
//                     controller: _emailController,
//                     expands: false,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       prefixIcon: Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                         borderSide: BorderSide(color: Colorpath.cardColor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                         borderSide: BorderSide(
//                           color: Colorpath.cardColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: _passwordController,
//                     expands: false,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                       prefixIcon: Icon(Icons.lock),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                         borderSide: BorderSide(color: Colorpath.cardColor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                         borderSide: BorderSide(
//                           color: Colorpath.cardColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: TextButton(
//                       onPressed: () => Get.to(ForgotScreen()),
//                       child: const Text(
//                         "Forgot Password",
//                         style: TextStyle(
//                           color: Colorpath.cardColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 60),
//                   Container(
//                     width: 300,
//                     height: 40,
//                     decoration: const BoxDecoration(),
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final email = _emailController.text;
//                         final password = _passwordController.text;
                        
//                         await authProviderlogin.loginApi(email, password);

//                         // Navigate to HomeScreen or perform other actions on success
//                         Get.to(HomeScreen());
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colorpath.cardColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Text(
//                         "Log In",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account?",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Get.to(SignUpScreen());
//                         },
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all(EdgeInsets.zero),
//                         ),
//                         child: const Text(
//                           "Sign up",
//                           style: TextStyle(color: Colorpath.cardColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
