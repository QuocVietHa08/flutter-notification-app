import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './event_item_detail.dart';
import 'package:demo_app/component/event_action_button.dart';

class EventItem extends StatefulWidget {
  final String title;
  final String content;
  final String location;
  final String date;
  final String time;
  final String groups;
  final int isImportant;
  final String attenders;
  final int status;
  final int id;
  final Function(String) deleteItem;

  const EventItem({
    super.key,
    required this.title,
    required this.content,
    required this.location,
    required this.attenders,
    required this.date,
    required this.isImportant,
    required this.groups,
    required this.id,
    required this.time,
    required this.status,
    required this.deleteItem,
  });

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    // final arrayAttenders =
    //     widget.attenders.substring(0, widget.attenders.length - 1).split(',');
    // final arrayGroups =
    //     widget.groups.substring(0, widget.groups.length - 1).split(',');
    // final numberOfAttenders = arrayAttenders.length;
    // final startTime = jsonDecode(widget.time)['startTime'];
    // final endTime = jsonDecode(widget.time)['endTime'];
    final dateFormat = DateFormat('MM/dd').format(DateTime.parse(widget.date));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventItemDetail(
                  id: widget.id,
                  time: widget.time,
                  content: widget.content,
                  date: widget.date,
                  isImportant: widget.isImportant,
                  groups: widget.groups,
                  title: widget.title,
                  location: widget.location,
                  attenders: widget.attenders,
                  status: widget.status,
                ),
              ),
            );
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(dateFormat)],
              ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(widget.content,
                    maxLines: 2, style: const TextStyle(fontSize: 18)),
              ),
              Row(
                children: [
                  EventActionButton(
                    id: widget.id,
                    status: widget.status,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
