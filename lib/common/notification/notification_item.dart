import 'package:flutter/material.dart';
import './notification_item_detail.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final List<String> tags;
  final bool isImportant;
  final int id;
  final String time;
  final Function(String) deleteItem;

  const NotificationItem({
    super.key,
    required this.id,
    required this.time,
    required this.title,
    required this.content,
    required this.date,
    required this.isImportant,
    required this.tags,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationItemDetail(
                        id: id,
                        time: time,
                        title: title,
                        content: content,
                        date: date,
                        isImportant: isImportant,
                        tags: tags,
                      )),
            );
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child:  Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Row(children: [
                    Expanded(
                        // padding: const EdgeInsets.only(right: 0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black,
                            // fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ]),
                ),
              ),
              Expanded(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text(date)],),
              ),
              // const Spacer(),
              // isImportant
              //     ? const Row(
              //         children: [
              //           Icon(
              //             Icons.notification_important,
              //             color: Colors.red,
              //             size: 18,
              //           ),
              //           Text("Important")
              //         ],
              //       )
              //     : const Text(""),
              // Spacer(),
              // InkWell(
              //   onTap: () {
              //     deleteItem(id.toString());
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(left: 10),
              //     child: Icon(
              //       Icons.delete,
              //       size: 17,
              //       color: Colors.red,
              //     ),
              //   ),
              // )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(content,maxLines: 2, style: const TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 10),
              // Row(
              //   children: [
              //     Text('Time:', style: TextStyle(fontWeight: FontWeight.bold),),
              //     Text('$time'),
              //   ],
              // )
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, bottom: 10),
              //   child: Text(content),
              // ),
              // Row(
              //   children: <Widget>[
              //     const Text("Tag:"),
              //     for (var _tag in tags)
              //       Padding(
              //         padding: const EdgeInsets.only(right: 10, left: 10),
              //         child: Text(
              //           '#$_tag',
              //           style: const TextStyle(
              //             color: Colors.blueAccent,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
