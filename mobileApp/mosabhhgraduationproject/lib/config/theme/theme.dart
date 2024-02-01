import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: AppColors.transparentYellow, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: AppColors.primaryBlue, opacity: 0.8),
  );
}