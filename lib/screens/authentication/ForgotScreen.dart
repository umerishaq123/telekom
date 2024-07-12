import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/ColorPath.dart';
import 'ResetPassword.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Forgot Password",
            ),
            const SizedBox(
              height: 10,
            ),

            ///heading
            const Text(
              "Don't worry sometime people can forgot too,\nenter your email and we will send you a password\nreset link",
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              expands: false,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
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
                      color:
                          Colorpath.cardColor), // Set color of unfocused border
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            ///submit button
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ));
                  },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colorpath.cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}


