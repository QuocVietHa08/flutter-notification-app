import 'package:flutter/material.dart';
// import './common//notification/notification_item.dart';
// import './common//notification//notification_create.dart';
import 'package:demo_app/common/event/event_item.dart';
import 'package:demo_app/common/event/event_create.dart';

class EventPage extends StatelessWidget {
   final List<Map<String, dynamic>> mockData = [
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'location': 'FLC Resort Ballroom',
      'date': '17/05/2023',
      'time': '17h00',
      'attenders': ['HQV', 'VVV', 'MVG'],
      'groups': ['Relipa', 'Bo'],
      'status': 0,
      'isImportant': true,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sự kiện"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EventCreate()),);
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: mockData.length,
        itemBuilder: (BuildContext context, int index) {
          final data = mockData[index];
          return EventItem(
            title: data['title'] ?? '',
            content: data['content'] ?? '',
            location: data['location'] ?? '',
            date: data['date'] ?? '',
            time: data['time'] ?? '',
            attenders: data['attenders'] ?? [],
            groups: data['groups'] ?? [],
            status: data['status'] ?? 0,
            isImportant: data['isImportant'] ?? false,
          );
        }
      ),
    );
  }
}