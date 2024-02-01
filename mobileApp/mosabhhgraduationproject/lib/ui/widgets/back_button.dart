import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget implements PreferredSizeWidget {
  const MyBackButton({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}