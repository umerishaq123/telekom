import 'package:flutter/material.dart';


class AppConstantsWidgetStyle {
  static List<BoxShadow> kShadows = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 4,
      offset: Offset(0, 4),
      spreadRadius: 0,
    )
  ];
  static ShapeDecoration KContainerStyleForTextFormField = ShapeDecoration(
      color: Colors.white, // Use your desired color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Define your shadows here
      shadows: AppConstantsWidgetStyle.kShadows);
  static ShapeDecoration KContainerStyleForParentWhiteContainer =
      ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: AppConstantsWidgetStyle.kShadows);

}
