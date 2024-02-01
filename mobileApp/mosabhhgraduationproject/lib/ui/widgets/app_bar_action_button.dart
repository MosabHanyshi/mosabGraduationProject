import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class AppBarActionButton extends StatelessWidget implements PreferredSizeWidget {
  const AppBarActionButton({super.key,required this.onMenueClicked,required this.onNotiClicked});
  final Future<void> Function() onMenueClicked;
  final Future<void> Function() onNotiClicked;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white08,
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  // onPressed: () {
                    //onMenueClicked.call();},
                  icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {  },
                ),
              ),
              Image.asset("assets/images/logo4.png",width: 40,height: 40,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white08,
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {onNotiClicked.call();},
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
