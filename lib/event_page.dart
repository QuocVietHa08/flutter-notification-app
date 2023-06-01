import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo_app/common/event/event_item.dart';
import 'package:demo_app/common/event/event_create.dart';
import 'package:http/http.dart' as http;

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List eventRes = [];
  bool isLoading = false;

  void fetchData() async {
    var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/event");
    setState(() {
      isLoading = true;
    });
    final res = await http.get(url);
    if (res.statusCode == 200) {
      var resData = res.body;
      var cloneData = jsonDecode(resData);
      List event = cloneData['data'];

      setState(() {
        eventRes = event;
      });
    } else {
      print('Request failed width status: ${res.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deleteEventItem(_id) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/event/$_id");
    final res = await http.delete(url);

    if (res.statusCode == 204) {
      fetchData();
    } else {
      print('Request failed width status: ${res.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sự kiện"),
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
      body: Stack(
        children: <Widget>[
          if (eventRes.isEmpty)
            const Center(
              child: Text("Không có thông báo!!"),
            )
          else
            Container(
              // height: 200,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: eventRes.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = eventRes[index];
                 
                  return EventItem(
                    id: data['id'] ?? 0,
                    title: data['title'] ?? '',
                    date: data['date'] ?? '',
                    time: data['time'] ?? '',
                    status: data['status_id'] ?? '',
                    groups: data['tags'] ??  '',
                    attenders: data['attenders'] ?? '',
                    location: 'Song Da Towel',
                    // isImportant: data['isImportant'],
                    isImportant: 1,
                    content: data['content'] ?? '',
                    deleteItem: _deleteEventItem,
                  );
                },
              ),
            ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
