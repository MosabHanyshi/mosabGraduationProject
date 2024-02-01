import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/route/app_routes.dart';
import 'config/route/route_generator.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteGenerator _appRouter = RouteGenerator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: getInitialPage(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  String getInitialPage() => AppRoutes.splashScreen;
}
