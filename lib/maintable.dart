import 'package:flutter/material.dart';
import 'package:planz/pages/page1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plan Z",
      debugShowCheckedModeBanner: false,
      home: TableTest(),
    );
  }
}
