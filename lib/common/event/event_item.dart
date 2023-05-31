import 'package:flutter/material.dart';
import './event_item_detail.dart';

class EventItem extends StatelessWidget {
  final String title;
  final String content;
  final String location;
  final String date;
  final String time;
  final List<String> groups;
  final bool isImportant;
  final List<String> attenders;
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
  Widget build(BuildContext context) {
    final numberOfAttenders = attenders.length;

    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventItemDetail(
                        id: id,
                        time: time,
                        content: content,
                        date: date,
                        isImportant: isImportant,
                        groups: groups,
                        title: title,
                        location: location,
                        attenders: groups,
                        // attenders: ['1', '2'],
                      )));
        },
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                date,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(time),
            const SizedBox(
              width: 15,
            ),
            // for (var _group in groups)
            //   Padding(
            //     padding: const EdgeInsets.only(right: 0, left: 5),
            //     child: Text(
            //       '#$_group',
            //       style: const TextStyle(
            //         color: Colors.blueAccent,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            const Spacer(),
            InkWell(
              onTap: () {
                deleteItem(id.toString());
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.delete,
                  size: 17,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(title, style: const TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                const Text("Tags"),
                for (var _group in groups)
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 5),
                    child: Text(
                      '#$_group',
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                const Icon(Icons.location_on),
                Text(location),
                const SizedBox(
                  width: 30,
                ),
                const Icon(Icons.group),
                const SizedBox(
                  width: 8,
                ),
                Text('$numberOfAttenders'),
                SizedBox(
                  width: 50,
                ),
                Text(
                  (() {
                    if (status == 0) {
                      return "Tentative";
                    } else if (status == 1) {
                      return "Accept";
                    }
                    return "Denied";
                  })(),
                  style: TextStyle(
                      color: status == 1
                          ? Colors.green
                          : status == 0
                              ? Colors.red
                              : Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
