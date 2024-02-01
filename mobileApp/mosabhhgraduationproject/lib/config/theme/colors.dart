import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF000000);
  static const kBackgroundColor = Color(0xff191720);
  static const kTextFieldFill = Color(0xff1E1C24);
  static const black015 = Color.fromRGBO(0, 0, 0, 0.15);
  static const black016 = Color.fromRGBO(0, 0, 0, 0.16);
  static const yellow = Color(0xffFDC054);
  static const yellow95 = Color.fromRGBO(243, 169, 95, 1.0);
  static const yellow91 = Color.fromRGBO(235, 101, 91, 1.0);
  static const transparentYellow03 = Color.fromRGBO(243, 169, 95, 0.3);
  static const transparentYellow091 = Color.fromRGBO(235, 101, 91, 0.3);
  static const blue51 = Color.fromRGBO(86, 201, 251, 1.0);
  static const blue76 = Color.fromRGBO(76, 170, 251, 1.0);
  static const transparentBlue3 = Color.fromRGBO(86, 201, 251, 0.3);
  static const transparentBlue02 = Color.fromRGBO(76, 170, 251, 0.3);
  static const blue02 = Color.fromRGBO(94, 201, 202, 1.0);
  static const blue59 = Color.fromRGBO(119, 235, 159, 1.0);
  static const primaryBlue = Color.fromRGBO(57, 167, 238, 1.0);
  Color dotColor = Colors.grey.withOpacity(.3);

  static const whiteFe = Color(0xfffefefe);
  static const white08 = Color.fromRGBO(255, 255, 255, 0.8);
  static const grey08 = Color.fromRGBO(124, 145, 158, 0.8);

  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
  static const Color darkGrey = Color(0xff202020);

  static List<Color> randomColors = [
    const Color(0xffFCE183),
    const Color(0xffF68D7F),
    const Color(0xffF749A2),
    const Color(0xffFF7375),
    const Color(0xff00E9DA),
    const Color(0xff5189EA),
    const Color(0xffAF2D68),
    const Color(0xff632376),
  ];
  static const List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];

  // Gradient
  static const mainButton = LinearGradient(colors: [
    Color.fromRGBO(236, 60, 3, 1),
    Color.fromRGBO(234, 60, 3, 1),
    Color.fromRGBO(216, 78, 16, 1),
  ], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);
}
