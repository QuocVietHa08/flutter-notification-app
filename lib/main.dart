import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Portal(
      child:  MaterialApp(
      home: LoginPage(),
    ));
  }
}

