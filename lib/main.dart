import 'package:demo_app/view/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/route_manager.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Portal(
      child:  MaterialApp(
      // home: SplashView(),
      home: LoginPage(),
    ));
  }
}


