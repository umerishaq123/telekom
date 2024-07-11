import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/signup_provider.dart';
import 'package:telekom2/screens/authentication/LoginScreeen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
       ChangeNotifierProvider(create: (_) => AuthProvider()),
       
       
    ],
    child:     const GetMaterialApp(
      

      home:  LoginScreen(),
    )
  
    );
 }
}

//// code is hare
