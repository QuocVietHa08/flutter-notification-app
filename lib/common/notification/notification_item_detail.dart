import 'package:flutter/material.dart';
import 'package:demo_app/common/layout/custom_footer_bar.dart';

class NotificationItemDetail extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final List<String> tags;
  final bool isImportant;
  final int id;
  final String time;

  const NotificationItemDetail({
    super.key,
    required this.id,
    required this.time,
    required this.title,
    required this.content,
    required this.date,
    required this.isImportant,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Noi dung thong bao"),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(children: [
          Row(
            children: [
              const Text(
                'Tiêu đề:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(title),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nội dung:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(content),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thời gian: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text('Ngày: $date, Giờ: $time'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Tag:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              for (var _tag in tags)
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Text(
                    '#$_tag',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          )
        ]),
      )),
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
