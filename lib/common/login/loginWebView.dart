import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewLogin extends StatefulWidget {
  @override
  _WebViewLoginState createState() => _WebViewLoginState();
}

class _WebViewLoginState extends State<WebViewLogin> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Example'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
