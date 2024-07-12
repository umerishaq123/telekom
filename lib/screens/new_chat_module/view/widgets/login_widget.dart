// // ignore_for_file: unused_import
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:telekom2/main.dart';

// import '../../service/firebase_firestore_service.dart';
// import '../../service/notification_service.dart';
// import '../screens/auth/forgot_password_page.dart';

// class LoginWidget extends StatefulWidget {
//   final Function() onClickedSignUp;
//   const LoginWidget({
//     Key? key,
//     required this.onClickedSignUp,
//   }) : super(key: key);

//   @override
//   State<LoginWidget> createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   // static final notifications = NotificationsService();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) =>
//       SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 60),
//               const FlutterLogo(size: 120),
//               const SizedBox(height: 40),
//               TextFormField(
//                 controller: emailController,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (email) => email != null &&
//                         !EmailValidator.validate(email)
//                     ? 'Enter a valid email'
//                     : null,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: passwordController,
//                 textInputAction: TextInputAction.done,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (value) =>
//                     value != null && value.length < 6
//                         ? 'Enter min. 6 characters'
//                         : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size.fromHeight(50),
//                 ),
//                 icon: const Icon(Icons.lock_open, size: 32),
//                 label: const Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 onPressed: signIn,
//               ),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 child: Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: Theme.of(context)
//                         .colorScheme
//                         .secondary,
//                     fontSize: 20,
//                   ),
//                 ),
//                 onTap: () => Navigator.of(context)
//                     .push(MaterialPageRoute(
//                   builder: (context) =>
//                       const ForgotPasswordPage(),
//                 )),
//               ),
//               const SizedBox(height: 24),
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                       color: Colors.black, fontSize: 20),
//                   text: 'No account?  ',
//                   children: [
//                     TextSpan(
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = widget.onClickedSignUp,
//                       text: 'Sign Up',
//                       style: TextStyle(
//                         decoration:
//                             TextDecoration.underline,
//                         color: Theme.of(context)
//                             .colorScheme
//                             .secondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );

//   Future signIn() async {
//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) =>
//           const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       await FirebaseFirestoreService.updateUserData(
//         {'lastActive': DateTime.now()},
//       );

//       // await notifications.requestPermission();
//       // await notifications.getToken();
//     } on FirebaseAuthException catch (e) {
//       final snackBar = SnackBar(content: Text(e.message!));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//     navigatorKey.currentState!
//         .popUntil(((route) => route.isFirst));
//   }

// }

// ignore_for_file: unused_import
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/main.dart';
import 'package:telekom2/provider/signup_provider.dart';
import 'package:telekom2/screens/authentication/ForgotScreen.dart';
import 'package:telekom2/screens/homescreeen/HomeScreen.dart';
import 'package:telekom2/screens/new_chat_module/provider/firebase_provider.dart';
import 'package:telekom2/utils/ColorPath.dart';
import '../../service/firebase_firestore_service.dart';
import '../../service/notification_service.dart';

class LoginWidget extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviderlogin =
        Provider.of<FirebaseProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 110),
                  Text(
                    "Sign In now",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colorpath.cardColor,
                    ),
                  ),
                  SizedBox(height: 80),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(color: Colorpath.cardColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colorpath.cardColor,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(color: Colorpath.cardColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colorpath.cardColor,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        : null,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => Get.to(ForgotScreen()),
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colorpath.cardColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(),
                    child: ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorpath.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: widget.onClickedSignUp,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colorpath.cardColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestoreService.updateUserData(
        {'lastActive': DateTime.now()},
      );
      final login = Provider.of<FirebaseProvider>(context, listen: false);
      await login.loginApi(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil(((route) => route.isFirst));
  }
}
