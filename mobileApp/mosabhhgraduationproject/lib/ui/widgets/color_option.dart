import 'package:flutter/cupertino.dart';

class ColorOption extends StatelessWidget {
  final Color color;

  const ColorOption(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)), color: color),
    );
  }
}