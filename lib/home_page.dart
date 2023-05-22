import 'package:demo_app/setting_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'calendar_page.dart';
import 'notification_page.dart';
import 'common/layout/CustomFooterBar.dart';

class HomePage extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Notification Application"),
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: CustomFooterBar(),
    );
  }

}
