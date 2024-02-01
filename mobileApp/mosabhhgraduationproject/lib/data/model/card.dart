import 'dart:ui';

import 'package:flutter/material.dart';

class CreditCard {
  int? id;
  int? number;
  int? cvv;
  String? name;
  int? year;
  String? month;
  CreditCardColor? color;
  bool? isDefault;


  CreditCard(
      {required this.id, required this.name, required this.number, required this.color, required this.cvv, required this.year, required this.month,required this.isDefault});
  CreditCard.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    cvv = json["cvv"];
    number=int.parse(json["number"]);
    year = json["year"];
    month = json["month"];
    isDefault=json["isDefault"];
    color =getComplementaryColor(json["color"]);
  }
  CreditCardColor getComplementaryColor(String color) {
    switch (color) {
      case "RED":
        return CreditCardColor.RED;
      case "BLUE":
        return CreditCardColor.BLUE;
      case "PURPLE":
        return CreditCardColor.PURPLE;
      case "GREEN":
        return CreditCardColor.GREEN;
      case "LIGHTBLUE":
        return CreditCardColor.LIGHTBLUE;
      default:
        throw ArgumentError("Unsupported CreditCardColor: $color");
    }
  }

}

enum CreditCardColor {RED,BLUE,PURPLE,GREEN,LIGHTBLUE}

extension CardExtension on CreditCardColor {

  Color? get color {
    switch (this) {
      case CreditCardColor.RED:
        return Colors.red;
      case CreditCardColor.BLUE:
        return Colors.blue;
      case CreditCardColor.PURPLE:
        return Colors.purple[700];
      case CreditCardColor.GREEN:
        return Colors.green[700];
      case CreditCardColor.LIGHTBLUE:
        return Colors.lightBlueAccent;
      default:
        return null;
    }
  }

}