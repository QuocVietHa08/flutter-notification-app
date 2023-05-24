import 'package:flutter/material.dart';
import 'package:demo_app/common/layout/custom_footer_bar.dart';

class NotificationItemDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Nội dung thông báo"),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              "Thông báo đi - hòn trống hòn mái",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            //     Text(
            //       "17/05/2023",
            //       style: TextStyle(
            //           decoration: TextDecoration.underline,
            //           color: Colors.blue[300]),
            //     ),
            //     Text("#BO"),
            //     Text("#HR"),
            //   ],
            // ),
            Text("content")
          ],
        ),
      ),
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
