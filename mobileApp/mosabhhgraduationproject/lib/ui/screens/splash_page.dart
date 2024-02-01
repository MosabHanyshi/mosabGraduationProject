
import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    User? user;
    SharedP().getCachedUser().then((value){
     user=value;
        if(user !=null){
      Navigator.pushNamed(context, AppRoutes.home);
    }else{

    Navigator.pushNamed(context, AppRoutes.login);}
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/blue_bg.png'), fit: BoxFit.cover)),
      child: Container(
color: AppColors.primaryBlue,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primaryBlue,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: Image.asset('assets/images/logo2.png')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
