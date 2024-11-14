import 'package:flutter/material.dart';
import '../widgets/draggable_widget.dart';
import '../widgets/drop_region.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to hold draggable containers
  List<String> containers = List.generate(5, (index) => 'Container ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: containers.map((container) {
                  return MyDraggableWidget(
                    data: container,  // Pass the container data
                  );
                }).toList(),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: MyDropRegion(),
            ),
          ),
        ],
      ),
    );
  }
}
