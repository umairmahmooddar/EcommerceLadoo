import 'package:superssecommerce/screens/auth/welcome_back_page.dart';
import 'package:superssecommerce/screens/intro_page.dart';
import 'package:superssecommerce/screens/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    int app = 2;
    if (app == 1) {
      return MaterialApp(
        title: 'eBazzar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat",
        ),
        home: IntroPage(), // SplashScreen(),
      );
    } else {
      return MaterialApp(
        title: 'eBazzar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat",
        ),
        home: WelcomeBackPage(), // SplashScreen(),
      );
    }
  }
}
