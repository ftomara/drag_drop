import 'package:flutter/material.dart';
import 'screens/rout-makeing-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Drag and Drop Example',
      home: Routmakeingscreen(), // This should now correctly reference HomeScreen from home_screen.dart
    );
  }
}
