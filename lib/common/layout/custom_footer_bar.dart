import 'package:flutter/material.dart';
import 'package:demo_app/home_page.dart';
import 'package:demo_app/notification_page.dart';
import 'package:demo_app/calendar_page.dart';
import 'package:demo_app/setting_page.dart';
import 'package:demo_app/event_page.dart';
import './tab_item.dart';

final tabs = ['Home', 'Event','Calendar', 'Noti', 'Settings'];

class CustomFooterBar extends StatefulWidget {
  @override
  State<CustomFooterBar> createState() => _CustomFooterBarState();
}

class _CustomFooterBarState extends State<CustomFooterBar> {
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem( text: tabs[0], icon: Icons.home, isSelected: selectedPosition == 0, handleClickEvent: () {
            // setState(() {
            //   selectedPosition = 0;
            // });
            Navigator.push(context, MaterialPageRoute(builder: (context )=> HomePage()));
          },),
          TabItem(text: tabs[1], icon: Icons.event, isSelected: selectedPosition == 1, handleClickEvent: () {
            print("hello");
            // setState(() {
            //   selectedPosition = 1;
            // });
            Navigator.push(context, MaterialPageRoute(builder: (context )=> EventPage()));
          },),
          TabItem(text: tabs[2], icon: Icons.calendar_month, isSelected: selectedPosition == 2, handleClickEvent: () {
            setState(() {
              selectedPosition = 2;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context )=> CalendarPage()));
          },),
          TabItem(text: tabs[3], icon: Icons.notifications, isSelected: selectedPosition == 3, handleClickEvent: () {
            // setState(() {
            //   selectedPosition = 3;
            // });
            Navigator.push(context, MaterialPageRoute(builder: (context )=> NotificationPage()));
          },),
          TabItem(text: tabs[4], icon: Icons.settings, isSelected: selectedPosition == 4, handleClickEvent: () {
            // setState(() {
            //   selectedPosition = 4;
            // });
            Navigator.push(context, MaterialPageRoute(builder: (context )=> SettingPage()));
          },),
        ],
      ),
    );
    // return BottomAppBar(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       IconButton(
    //         icon: const Icon(
    //           Icons.group,
    //           size: 30,
    //         ),
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => HomePage()),
    //           );
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.calendar_today,
    //           size: 30,
    //         ),
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => CalendarPage()),
    //           );
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.event,
    //           size: 30,
    //         ),
    //         onPressed: () {
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => EventPage()));
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.notifications,
    //           size: 30,
    //         ),
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => NotificationPage()),
    //           );
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.settings,
    //           size: 30,
    //         ),
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => SettingPage()),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}
