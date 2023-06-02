import 'package:demo_app/event_page.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/common/layout/custom_footer_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class EventItemDetail extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final String groups;
  final String attenders;
  final int isImportant;
  final int id;
  final String time;
  final String location;
  final int status;

  const EventItemDetail({
    super.key,
    required this.id,
    required this.time,
    required this.title,
    required this.content,
    required this.date,
    required this.isImportant,
    required this.groups,
    required this.location,
    required this.attenders,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final arrayAttenders =
        attenders.substring(0, attenders.length - 1).split(',');

    final arrayGroups = groups.substring(0, groups.length - 1).split(',');

    final numberOfAttenders = arrayAttenders.length;
    final startTime = jsonDecode(time)['startTime'];
    final endTime = jsonDecode(time)['endTime'];
    final dateFormat = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));

    void _joinEventHandle() async {
      var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/event/$id");

      var submitData = {
        "id": id,
        "title": title,
        "content": content,
        "status_id": 1,
        "date": date,
        "time": time,
        "tags": groups,
        "address": location,
        "attenders": attenders
      };

      final res = await http.put(url,
          body: jsonEncode(submitData),
          headers: {"Content-Type": "application/json"});
      if (res.statusCode == 204) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(),));
      } 
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Event detail"),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(children: [
          Row(
            children: [
              const Text(
                'Title: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(title),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Content: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  content,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Time: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Flexible(child: 
              Text('Date: $dateFormat, Time: $startTime - $endTime'),),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Tag:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              for (var _groups in arrayGroups)
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Text(
                    '#$_groups',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Attenders:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(numberOfAttenders.toString())
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Location:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(location),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Status:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              if (status == 0)
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Text(
                          'Accesst',
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text(
                          'Deny',
                        ))
                  ],
                ),
              if (status == 1)
                Text(
                  'Accept',
                  style: TextStyle(color: Colors.green),
                ),
              if (status == 2)
                Text(
                  'Deny',
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        ]),
      )),
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
