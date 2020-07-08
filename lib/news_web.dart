import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsInAWeb extends StatefulWidget {
  final url;
  NewsInAWeb(this.url);
  @override
  createState() => _NewsInAWeb(this.url);
}

class _NewsInAWeb extends State<NewsInAWeb> {
  final String url;
  final _key = UniqueKey();
  _NewsInAWeb(this.url);

  num _stackindex = 1;
  void _handleLoad(String value) {
    setState(() {
      _stackindex = 0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _stackindex,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: WebView(
                  initialUrl: this.url,
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: _handleLoad,
                ),
              ),
            ],
          ),
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
