import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telkom/screens/authentication/ForgotScreen.dart';
import 'package:telkom/screens/homescreeen/HomeScreen.dart';

import '../../utils/ColorPath.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 15 ,horizontal: 15),
          child:       Form(


              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    SizedBox(height: 110,),

                    Text("Sign In now" ,style: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 18 ,fontFamily: GoogleFonts.aBeeZee().fontFamily ,color: Colorpath.cardColor),),


                    SizedBox(height: 80,),
                    //email
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "gmail",
                        prefixIcon: Icon(Iconsax.user),
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
                              color:
                              Colorpath.cardColor), // Set color of unfocused border
                        ),            ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),




                    TextFormField(
                      expands: false,

                      decoration: const InputDecoration(
                        labelText: "password",
                        prefixIcon: Icon(Iconsax.eye_slash),
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
                        ),            ),
                    ),



                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: ()=>Get.to(ForgotScreen()),
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: Colorpath.cardColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),

                SizedBox(height: 60,),
                Container(
                  width: 300,
                  height: 40,
                  decoration: const BoxDecoration(),
                  child: ElevatedButton(
                      onPressed:  ()=>Get.to(HomeScreen()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colorpath.cardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(16))),
                      child:  Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      )),
                )
,
                    SizedBox(height: 40,),

                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colorpath.cardColor),
                      ),
                    )
                  ],
                )

                ],
                ),
              ))
          ,
        ),
      ),
    );
  }
}
