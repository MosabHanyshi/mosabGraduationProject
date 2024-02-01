import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';


class CurvedLeftShadow extends StatelessWidget {
  const CurvedLeftShadow({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: LeftShadowClipper(),
      child: Container(
        height: 320.0,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.transparentYellow03,
              AppColors.transparentYellow091
            ],
          ),
        ),
      ),
    );
  }
}

class LeftShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(35, size.height - 10, 45, size.height - 50);
    path.quadraticBezierTo(90, 90, size.width - 120, 80);
    path.quadraticBezierTo(size.width, 70, size.width, 25);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
