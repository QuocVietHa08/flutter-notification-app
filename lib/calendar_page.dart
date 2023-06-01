import 'package:demo_app/event_page.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:demo_app/common/layout/custom_footer_bar.dart';
import 'package:demo_app/common/event/event_create.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng lịch"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventCreate()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: MonthView(
        controller: EventController(),
        cellBuilder: (date, event, isToday, isInMonth) {
          return Container(
            decoration: BoxDecoration(
              color: isToday ? Colors.blue : Colors.transparent,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(color: isToday ? Colors.white : Colors.black),
              ),
            ),
          );
        },
        minMonth: DateTime(1990),
        maxMonth: DateTime(2050),
        // cellAspectRatio: 1.3,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage()));
        },
        startDay: WeekDays.sunday,
        onEventTap: (event, date) => print("checking 1"),
        onDateLongPress: (date) => print("checking 2"),
      ),
    );
  }
}
