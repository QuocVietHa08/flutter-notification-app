import 'package:flutter/material.dart';
import './common//notification/notification_item.dart';
import './common//notification//notification_create.dart';

class NotificationPage extends StatelessWidget {
   final List<Map<String, dynamic>> mockData = [
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': true,

    },
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': false,

    },
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': true,

    },
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': false,

    },
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': false,

    },

    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': false,

    },
    {
      'title': 'Thông báo đi - hon trống hòn mái',
      'content': 'Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật',
      'date': '17/05/2023',
      'tags': ['Relipa', 'Bo'],
      'isImportant': false,

    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationCreate()),);
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: mockData.length,
        itemBuilder: (BuildContext context, int index) {
          final data = mockData[index];
          return NotificationItem(
            title: data['title'] ?? '',
            date: data['date'] ?? '',
            tags: data['tags'] ?? ['hello', 'hi'], 
            content: data['content'] ?? '',
            isImportant: data['isImportant'] ?? false,
          );
        }
      ),
    );
  }
}