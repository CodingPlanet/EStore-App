import 'package:ecom/screen/order/load_web_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatefulWidget {
  String url;
  int OrderId;
  WebViewScreen({required this.url, required this.OrderId});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text("CheckOut"),
      ),
      body: LoadWebView(
        url: widget.url,
        OrderId: widget.OrderId,
      ),
    );
  }
}
