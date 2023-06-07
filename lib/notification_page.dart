import 'dart:convert';

import 'package:demo_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './common//notification/notification_item.dart';
import './common//notification//notification_create.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List notificationRes = [];
  bool isLoading = false;

  void fetchData() async {
    var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/notification");

    setState(() {
      isLoading = true;
    });

    final res = await http.get(url);

    if (res.statusCode == 200) {
      var resData = res.body;
      var cloneData = jsonDecode(resData);
      List notifications = cloneData["data"];

      setState(() {
        notificationRes = notifications;
      });
    } else {
      print('Request failed width status: ${res.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deleteNotificationitem(_id) async {
    setState(() {
      isLoading = true;
    });
    var url =
        Uri.parse("https://api.co-event.relipa.vn/api/v1/notification/$_id");
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
        // automaticallyImplyLeading: false,
        title: const Text("Notification Page"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationCreate()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: <Widget>[
          if (notificationRes.isEmpty)
            const Center(
              child: Text("Empty!!"),
            )
          else
            ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: notificationRes.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = notificationRes[index];
                  var date = DateTime.parse(data['date']);
                  String dateFormat = DateFormat('MM/dd').format(date);
                  var time = data['time'];
                  var arrayTags = data['tags'].substring(0, data['tags'].length - 1).split(',');
                  // print(data);
                  return NotificationItem(
                    id: data['id'] ?? 0,
                    title: data['title'] ?? '',
                    date: dateFormat,
                    time: time,
                    isImportant: data['isImportant'] == 1 ? true : false,
                    tags: arrayTags,
                    content: data['content'] ?? '',
                    deleteItem: _deleteNotificationitem,
                  );
                }),
          if (isLoading)
            Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                )),
        ],
      ),
    );
  }
}
