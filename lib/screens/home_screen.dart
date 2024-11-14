import 'package:drag_drop/model/machine.dart';
import 'package:flutter/material.dart';
import '../widgets/draggable_widget.dart';
import '../widgets/drop_region.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to hold draggable containers
  final List<Machine> _machines = [
    Machine(name: 'Cutting'),
    Machine(name: 'Drilling'),
    Machine(name: 'Welding'),
    Machine(name: 'Grinding'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _machines.map((machine) {
                return MyDraggableWidget(
                  data: machine, // Pass the container data
                );
              }).toList(),
            ),
          ),
          const Divider(),
          // Wrap MyDropRegion in a Flex widget like Column or Row
          Expanded(
            child: MyDropRegion(),
          ),
        ],
      ),
    );
  }
}
