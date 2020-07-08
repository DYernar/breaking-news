import 'package:flutter/material.dart';
import 'package:flutter_news/feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/news2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Builder(builder: (context) {
                return RaisedButton(
                    color: Color.fromRGBO(155, 150, 140, 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsFeed()))
                        },
                    child: Text(
                      "read",
                      style: TextStyle(color: Colors.white54),
                    ));
              }),
            )),
      ),
    );
  }
}
