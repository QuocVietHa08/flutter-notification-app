import 'package:flutter/material.dart';
import 'common/layout/custom_footer_bar.dart';

class HomePage extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Ứng dụng thông báo"),
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: CustomFooterBar(),
    );
  }

}
