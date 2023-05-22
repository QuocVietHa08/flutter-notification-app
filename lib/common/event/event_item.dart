import 'package:flutter/material.dart';
// import  './notification_item_detail.dart';

class EventItem extends StatelessWidget {

  final String title;
  final String content;
  final String location;
  final String date;
  final List<String> groups;
  final bool isImportant;
  final int attenders;


  const EventItem(
      {super.key,
      required this.title,
      required this.content,
      required this.location,
      required this.attenders,
      required this.date,
      required this.isImportant,
      required this.groups});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationItemDetail()),);
        },
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                date,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isImportant ? 
            Row(children: const [
              Icon(Icons.notification_important, color: Colors.red, size: 18,),
              Text("Important")
            ],)
            : const Text(""),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18
                )
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(content),
            ),
            Row(
              children: <Widget>[
                const Text("Tag:"),
                for (var _group in groups)
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      '#$_group',
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
