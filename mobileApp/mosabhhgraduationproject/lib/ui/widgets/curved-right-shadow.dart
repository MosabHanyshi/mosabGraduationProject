import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class CurvedRightShadow extends StatelessWidget {
  const CurvedRightShadow({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return ClipPath(
      clipper: RightShadowClipper(),
      child: Container(
        height: 270.0,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.transparentBlue3,
              AppColors.transparentBlue02
            ],
          ),
        ),
      ),
    );
  }
}

class RightShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(20, size.height);
    path.quadraticBezierTo(
      40,
      size.height - 35,
      130,
      size.height - 47,
    );
    path.quadraticBezierTo(
      size.width - 60,
      size.height - 90,
      size.width - 25,
      40,
    );
    path.quadraticBezierTo(
      size.width - 10,
      0,
      size.width,
      0,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(20, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
