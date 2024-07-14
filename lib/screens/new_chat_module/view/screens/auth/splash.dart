import 'package:flutter/material.dart';
import 'package:telekom2/screens/homescreeen/HomeScreen.dart';
import 'package:telekom2/screens/new_chat_module/view/screens/auth/auth_page.dart';
import 'package:telekom2/utils/ColorPath.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    // Delay navigation by 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to your desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => isLogin ? const HomeScreen() : AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colorpath.cardColor,
        child: Center(
            child: Image.asset(
          'assets/logo.png',
          width: width * 0.5,
          height: height * 0.3,
        )),
      ),
    );
  }
}
