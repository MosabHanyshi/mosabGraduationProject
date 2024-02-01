import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/catagory/category_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/fav_product_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/products_cubit.dart';
import 'package:mosabhhgraduationproject/config/app_data.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/cart_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/category_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/product_data_provider.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cart_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/category_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/product_repo.dart';
import 'package:mosabhhgraduationproject/ui/screens/cart_screen.dart';
import 'package:mosabhhgraduationproject/ui/screens/favorite_screen.dart';
import 'package:mosabhhgraduationproject/ui/screens/product_list_screen.dart';
import 'package:mosabhhgraduationproject/ui/screens/profile_page.dart';
import 'package:mosabhhgraduationproject/ui/widgets/app_bar_action_button.dart';
import 'package:mosabhhgraduationproject/ui/widgets/drawer.dart';
import 'package:mosabhhgraduationproject/ui/widgets/page_wrapper.dart';
import 'package:bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  ProductRepo? productRepo;
  List<Widget> screens = [];
ProductsCubit? productsCubit;
  int newIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _configureFCM() {
    // Request permission for receiving push notifications (iOS only)
    _fcm.requestPermission(alert: true, badge: true, sound: true);

    // Handle incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    // Handle notification clicks when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    // Handle notification clicks when the app is terminated
    _fcm.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("getInitialMessage: $message");
        // Handle the initial message as needed
      }
    });

    // Get the FCM token
    _fcm.getToken().then((String? token) {
      print("FCM Token: $token");
    }).catchError((e) {
      print("Error getting FCM token: $e");
    });
  }
  @override
  void initState() {
    productRepo = ProductRepo(ProductDataProvider());
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => ProductsCubit(productRepo!)),
          BlocProvider(create: (BuildContext context) => CategoryCubit(CategoriesRepo(CategoryDataProvider())))

        ],
        child: const ProductListScreen(),
      ),
      BlocProvider(
        create: (context) => ProductsCubit(productRepo!),
        child: FavoriteScreen(),
      ),
      BlocProvider(
          create: (context) => CartCubit(CartRepo(CartDataProvider())),
          child:CartScreen()),
      ProfilePage()
    ];
    _configureFCM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBarActionButton(
          onMenueClicked: () async {
            _scaffoldKey.currentState?.openDrawer();
          },
          onNotiClicked: () async {},
        ),
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: AppData.bottomNavyBarItems
              .map(
                (item) =>
                BottomNavyBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeColor: item.activeColor,
                  inactiveColor: item.inActiveColor,
                ),
          )
              .toList(),
          onItemSelected: (currentIndex) {
            newIndex = currentIndex;
            setState(() {});
          },
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: screens[newIndex],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
