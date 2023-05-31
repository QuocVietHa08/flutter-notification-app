import 'package:flutter/material.dart';
import 'package:demo_app/common/layout/custom_footer_bar.dart';

class EventItemDetail extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final List<String> groups;
  final List<String> attenders;
  final bool isImportant;
  final int id;
  final String time;
  final String location;

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
  });

  @override
  Widget build(BuildContext context) {
    final numberOfAttenders = attenders.length;

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
          const SizedBox(
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
          const SizedBox(
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const Text(
                "Tag:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              for (var _groups in groups)
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
              Text(attenders.length.toString())
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
        ]),
      )),
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
