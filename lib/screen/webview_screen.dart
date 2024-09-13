import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  // Method AppBar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // text flutter
          Text(
            'Flutter',
            style: TextStyle(color: Colors.grey[800], fontSize: 17),
          ),
          // text news
          const Text(
            'News',
            style: TextStyle(fontSize: 17, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
