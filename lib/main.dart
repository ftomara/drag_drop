import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drag and Drop Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // This should now correctly reference HomeScreen from home_screen.dart
    );
  }
}
