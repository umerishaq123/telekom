import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telekom2/provider/logoutby_provider.dart';
import 'package:telekom2/provider/session_handling_provider.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/login_widget.dart';
import 'package:telekom2/utils/utils.dart';

class TeacherDrawerWidget extends StatefulWidget {
  const TeacherDrawerWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<TeacherDrawerWidget> createState() => _TeacherDrawerWidgetState();
}

class _TeacherDrawerWidgetState extends State<TeacherDrawerWidget> {
  bool isLogin = true;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Drawer(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          const Divider(),
          ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFFF0000)),
              title: const Text(
                'Logout',
              ),
              onTap: () async {
           try {
                  final sessionHandler = SessionHandlingViewModel();
                  final token = await sessionHandler.getToken();

                  if (token != null) {
                    await LogoutbyProvider().logout();
                  }

                  // Clear user session data
                  await sessionHandler.removeUser();

                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWidget(onClickedSignUp: toggle),
                    ),
                  );
                } catch (e) {
                  print('Logout error: $e');
                  Utils.toastMessage('Logout error: $e');

                  // Ensure user is logged out and session is cleared
                  await SessionHandlingViewModel().removeUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWidget(onClickedSignUp: toggle),
                    ),
                  );
                }
              
              }

              // onTap:

              //   () async {
              //     try {
              //       // Call your logout API

              //       // Clear any session data or perform other cleanup
              //      await LogoutbyProvider().logout();
              //       await SessionHandlingViewModel()
              //           .removeUser()
              //           .then((Value) {

              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   LoginWidget(onClickedSignUp: toggle)),
              //         );
              //       });

              //       // Navigate to the login screen
              //     } catch (e) {
              //       print('Logout error: $e');
              //       // Handle logout error
              //     }
              //   }
              //   // SessionHandling().removeEverything();
              // Navigator.pushReplacementNamed(
              //           //     context, RoutesName.loginScreen);
              //           SessionHandlingViewModel().removeUser();
              //          Navigator.pushReplacement(
              // context,
              // MaterialPageRoute(builder: (context) => LoginWidget(onClickedSignUp:toggle)));
              )
        ]),
      ),
    );
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
