import 'package:flutter/material.dart' show Color, IconData;
import 'package:mosabhhgraduationproject/data/model/product.dart';

class ProductCategory {
  ProductType? type;
  bool? isSelected;
  String? asset = 'assets/imgs/headphones_3.png';

  ProductCategory(this.type, this.isSelected, this.asset);

  ProductCategory.fromJson(Map<String, dynamic> json) {
    type = Product.getProductTypeFromString(json["category_name"]);
    isSelected = json['category_id']==1;
    asset=json["category_image_path"];
    }

  ProductCategory copyWith({
    ProductType? type,
    bool? isSelected,
    IconData? icon,
    String? asset,
  }) {
    return ProductCategory(
      type ?? this.type,
      isSelected ?? this.isSelected,
      asset ?? this.asset,
    );
  }
}
