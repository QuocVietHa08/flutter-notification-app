import 'package:flutter/material.dart';
import 'package:demo_app/home_page.dart';
import 'package:demo_app/notification_page.dart';
import 'package:demo_app/calendar_page.dart';
import 'package:demo_app/setting_page.dart';

class CustomFooterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.group),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()),);
              },
            )
          ],
        ),
      );
  }
}