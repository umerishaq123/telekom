// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:telekom2/screens/authentication/LoginScreeen.dart';
// import 'package:telekom2/screens/chats/firebase_provider.dart';
// // Import the generated file
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => FirebaseProvider()),
//       ],
//       child: const GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

// //// code is hare

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/provider/list_of_lecture_provider.dart';
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/provider/signup_provider.dart';

import 'firebase_options.dart';
import 'screens/new_chat_module/provider/firebase_provider.dart';
import 'screens/new_chat_module/view/screens/auth/auth_page.dart';
import 'screens/new_chat_module/view/screens/auth/verify_email_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get mainColor => null;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FirebaseProvider()),
          ChangeNotifierProvider(create: (_) => SessionHandlingViewModel()),
          ChangeNotifierProvider(create: (_) => NotesProvider()),
           ChangeNotifierProvider(create: (_) => ImageToTextProvider()),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: const Size.fromHeight(52),
                backgroundColor: mainColor,
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: const MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return const AuthPage();
          },
        ),
      );
}

///// new one
////////////////////////////////new one//////////////////////////