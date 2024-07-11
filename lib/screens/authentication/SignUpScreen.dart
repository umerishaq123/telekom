import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:telekom2/utils/ColorPath.dart';

import '../homescreeen/HomeScreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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

                //email
                TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "name",
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
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "number",
                    prefixIcon: Icon(Icons.numbers),
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
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "email",
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
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "password",
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
                  height: 90,
                ),

                Container(
                  width: 300,
                  height: 40,
                  decoration: const BoxDecoration(),
                  child: ElevatedButton(
                      onPressed: () => Get.to(HomeScreen()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colorpath.cardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
