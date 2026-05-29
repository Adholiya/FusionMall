import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: use_key_in_widget_constructors
class SupportPage extends StatefulWidget {
  @override
  _SupportPage createState() => _SupportPage();
}

class _SupportPage extends State<SupportPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    _controller = WebViewController();

    // Load the HTML file from assets
    _controller.loadFlutterAsset('assets/conact_us/contact_us.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect To FusionMall'),
      ),
      body: WebViewWidget(controller: _controller),  // Render WebView
    );
  }
}
