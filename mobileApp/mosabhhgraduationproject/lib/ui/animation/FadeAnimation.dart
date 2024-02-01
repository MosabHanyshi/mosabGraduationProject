import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {


    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(seconds: 1),
      tween:Tween<double>(begin: 0.0, end: 1.0),
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: Offset(animation, 0),
          child: child,
        ),
      ),
    );
  }
}
