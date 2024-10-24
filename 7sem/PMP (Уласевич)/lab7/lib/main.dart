import 'package:flutter/material.dart';
import 'WorkListPage.dart';

void main() async {
  runApp(WorkApp());
}

class WorkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Teams',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkListPage(),
    );
  }
}
