import 'dart:ffi';

import 'package:mosabhhgraduationproject/data/model/product_size_type.dart';

enum ProductType { input, output, controller }

class Product {
  late int? id;
  late String name;
  late int price;
  late int? off;
  late String about;
  late bool isAvailable;
  late ProductSizeType? sizes;
  late int _quantity;
  late List<String> images;
  late bool isFavorite;
  late double rating;
  late ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.about,
    required this.isAvailable,
    this.sizes,
    required this.off,
    required int quantity,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
  }) : _quantity = quantity;

  Product.fromJson(Map<String, dynamic> json) {
    id = json["product_id"];
    name = json["product_name"];
    price = json["product_price"];
    about = json["product_description"];
    isAvailable = true;
    sizes = null;
    off = json["discount_percentage"] == null
        ? null
        : int.parse(json["discount_percentage"]);
    _quantity = 0;
    images = test(json["product_img_path"]);
    isFavorite = json["isFav"];
    rating = json["rating"] == null ? 0.0 : json["rating"] * 1.0;
    type = getProductTypeFromString(json["product_category"]);
  }

  List<String> test(String img) {
    List<String> we = [];
    we.add(img);
    we.add("/images/159095_1566967762.png");
    we.add("/images/ultrasonic-sensor-HCSR04-1.png");

    return we;
  }

  static ProductType getProductTypeFromString(String input) {
    switch (input.toLowerCase()) {
      case "input":
        return ProductType.input;
      case "output":
        return ProductType.output;
      case "controller":
        return ProductType.controller;
      default:
        throw ArgumentError("Invalid string value: $input");
    }
  }
}
