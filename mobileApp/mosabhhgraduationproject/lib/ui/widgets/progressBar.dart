import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

