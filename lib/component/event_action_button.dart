import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventActionButton extends StatelessWidget {
  final int id;
  final int status;

  const EventActionButton({
    super.key,
    required this.id,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        status != 0
            ? Text("hello")
            : Row(children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Accept')),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Deny'))
              ])
        // ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.green,
        //     ),
        //     child: Text('Accept')),
        //   const SizedBox(width: 10),
        //   ElevatedButton(
        //       onPressed: () {},
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.red,
        //       ),
        //   child: Text('Deny'))
      ],
    );
  }
}
