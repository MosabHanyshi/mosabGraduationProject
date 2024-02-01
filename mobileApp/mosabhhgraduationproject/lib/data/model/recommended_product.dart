import 'package:flutter/material.dart' show Color, Colors;
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class RecommendedProduct {
  Color? cardBackgroundColor;
  Color? buttonTextColor;
  Color? buttonBackgroundColor;
  String? imagePath;

  RecommendedProduct({
    this.cardBackgroundColor,
    this.buttonTextColor =AppColors.primaryBlue,
    this.buttonBackgroundColor = Colors.white,
    this.imagePath,
  });
}
