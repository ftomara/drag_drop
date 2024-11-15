import 'package:drag_drop/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Drag and Drop Example',
      home: HomeScreen(), // This should now correctly reference HomeScreen from home_screen.dart
    );
  }
}
