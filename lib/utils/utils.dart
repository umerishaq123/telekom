import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utils {
  // Function to dismiss the keyboard
  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }

  // static void flushBarErrorMessage(String message, BuildContext context) {
  //   showFlushbar(
  //     context: context,
  //     flushbar: Flushbar(
  //       forwardAnimationCurve: Curves.decelerate,
  //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       padding: const EdgeInsets.all(15),
  //       message: message,
  //       duration: const Duration(seconds: 3),
  //       borderRadius: BorderRadius.circular(8),
  //       flushbarPosition: FlushbarPosition.TOP,
  //       backgroundColor: Colors.red,
  //       reverseAnimationCurve: Curves.easeInOut,
  //       positionOffset: 20,
  //       icon: const Icon(
  //         Icons.error,
  //         size: 28,
  //         color: Colors.white,
  //       ),
  //     )..show(context),
  //   );
  // }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          )));
  }
  
}