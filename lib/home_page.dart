import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'common/layout/custom_footer_bar.dart';
import './common//notification/notification_item.dart';
import './common/event/event_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notificationRes = [];
  List eventRes = [];
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

  void fetchEventData() async {
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

  // void _deleteEventItem(_id) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/event/$_id");
  //   final res = await http.delete(url);

  //   if (res.statusCode == 204) {
  //     fetchData();
  //   } else {
  //     print('Request failed width status: ${res.statusCode}');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchData();

    fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Notification App"),
      ),
      body: Container(
        child: Stack(
        children: <Widget>[
          if (notificationRes.isEmpty)
            const Center(
              child: Text("Empty !!"),
            )
          else
            ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  final data = notificationRes[index];
                  var date = DateTime.parse(data['date']);
                  String dateFormat = DateFormat('MM/dd').format(date);
                  var time = data['time'];
                  var arrayTags = data['tags']
                      .substring(0, data['tags'].length - 1)
                      .split(',');

                  return Dismissible(
                    onDismissed: (direction) {
                      _deleteNotificationitem(data['id']);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${data['title']} dismissed")));
                    },
                    key: Key(index.toString()),
                    background: Container(
                      color: Colors.grey, 
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Delete', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ) 
                    ),
                    child: 
                    NotificationItem(
                      id: data['id'] ?? 0,
                      title: data['title'] ?? '',
                      date: dateFormat,
                      time: time,
                      isImportant: data['isImportant'] == 1 ? true : false,
                      tags: arrayTags,
                      content: data['content'] ?? '',
                      deleteItem: _deleteNotificationitem,
                    ));
                }),
          // if (eventRes.isEmpty)
          //   const Center(
          //     child: Text("Không có sự kiện sắp tới!!"),
          //   )
          // else
          //   ListView.builder(
          //       physics: const AlwaysScrollableScrollPhysics(),
          //       padding: const EdgeInsets.all(8),
          //       itemCount: 2,
          //       itemBuilder: (BuildContext context, int index) {
          //        final data = eventRes[index];
          //         var date = DateTime.parse(data['date']);
          //         String dateFormat = DateFormat('yyyy-MM-dd').format(date);
          //         var time = data['time'];
          //         var arrayTags = data['tags']
          //             .substring(0, data['tags'].length - 1)
          //             .split(',');

          //         return NotificationItem(
          //           id: data['id'] ?? 0,
          //           title: data['title'] ?? '',
          //           date: dateFormat,
          //           time: time,
          //           isImportant: data['isImportant'] == 1 ? true : false,
          //           tags: arrayTags,
          //           content: data['content'] ?? '',
          //           deleteItem: _deleteNotificationitem,
          //         ); 
          //       }),
          if (isLoading)
            Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                )),
        ],
      )),
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
