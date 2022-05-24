import 'package:flutter/material.dart';
import 'View/root_app.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor Mentee Connecting',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: RootApp(),
    );
  }
}
