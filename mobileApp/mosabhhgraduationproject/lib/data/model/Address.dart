import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Address{
  int? id;
  String? name;
  bool? isSelected;
  IconData? icon;
  double? Lat;
  double? Lng;
  String? placeName;

  Address(this.name, this.isSelected, this.icon,this.Lat,this.Lng,this.placeName);
  Address.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    Lat = json["lat"];
    Lng = json["lang"];
    isSelected = false;
    icon = test(json["name"]);
    placeName = json["place"];
  }

  IconData test(String img) {
    return img=="Home"||img=="home"?Icons.home:img=="Work"||img=="work"?Icons.location_city:Icons.location_on;

  }
}