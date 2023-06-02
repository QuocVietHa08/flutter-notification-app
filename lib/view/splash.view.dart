import 'dart:async';
import 'package:get/get.dart';
import 'package:demo_app/login_page.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginPage());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: const Text(
              "Relipa Notification App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue),
            ),
          ),
          const Text("Powered by Relipa R&D Team", style: TextStyle(fontSize: 12),),
        ],
      )),
    );
  }
}
