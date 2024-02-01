import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class CurvedLeft extends StatelessWidget {
  const CurvedLeft({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: LeftClipper(),
      child: Container(
        height: 300.0,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.yellow95,
              AppColors.yellow91
            ],
          ),
        ),
      ),
    );
  }
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width , 0);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(30, size.height, 40, size.height - 40);
    path.quadraticBezierTo(80, 80, size.width - 120, 70);
    path.quadraticBezierTo(size.width, 60, size.width, 0);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
