// ignore_for_file: unused_import
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telekom2/main.dart';
import 'package:telekom2/provider/signup_provider.dart';
import 'package:telekom2/screens/authentication/ForgotScreen.dart';
import 'package:telekom2/screens/homescreeen/HomeScreen.dart';
import 'package:telekom2/screens/new_chat_module/provider/firebase_provider.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/signup_widget.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:telekom2/utils/utils.dart';
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
  bool isLogin = true;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

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
      appBar: AppBar(
        title: Text(
          'Sign In Now',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colorpath.cardColor,
          ),
        ),
        centerTitle: true,
      ),
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
                  
                  TextFormField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "username",
                      prefixIcon: Icon(Icons.person),
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
                    // validator: (email) =>
                    //     email != null && !EmailValidator.validate(email)
                    //         ? 'Enter a valid email'
                    //         : null,
                  ),
                  const SizedBox(height: 20),
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
                    // obscureText: true,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
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
                      onPressed: () {},
                      // onPressed: () => Get.to(ForgotScreen()),
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
                  SizedBox(height: 5),
                  Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(),
                    child: Builder(builder: (context) {
                      return Builder(builder: (context) {
                        return Consumer<FirebaseProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return ElevatedButton(
                              onPressed: value.isLoading ? null : signIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colorpath.cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (!value.isLoading)
                                    const Text(
                                      "Log In",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  if (value.isLoading)
                                    (CircularProgressIndicator())
                                ],
                              ),
                            );
                          },
                        );
                      });
                    }),
                  ),
                  SizedBox(height: 5),
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpWidget(onClickedSignIn: toggle)),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colorpath.cardColor),
                          ),
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

  Future<void> signIn() async {
    Utils.dismissKeyboard(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // Call your API using Provider
    final loginProvider = Provider.of<FirebaseProvider>(context, listen: false);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await loginProvider
          .loginApi(usernameController.text.trim(),
              passwordController.text.trim(), context)
          .then((value) {
        prefs.setString('email', emailController.text);
        prefs.setBool('isLogin', true);
        GetMeEmail.senderId = emailController.text;
      });

      // Successfully signed in with Firebase
      await FirebaseFirestoreService.updateUserData({
        'lastActive': DateTime.now(),
      });

      // Navigate to HomeScreen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    } catch (apiError) {
      // Handle API error
      final snackBar = SnackBar(content: Text('API login failed: $apiError'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      // Close progress indicator dialog
      // Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
