import 'package:drag_drop/model/machine.dart';
import 'package:flutter/material.dart';
import '../widgets/cutting_setup_dialog.dart';
import '../widgets/dotted_bg.dart';
import '../widgets/draggable_widget.dart';

import '../widgets/drop_region.dart'; // Import the dialog file

class Routmakeingscreen extends StatefulWidget {
  const Routmakeingscreen({super.key});

  @override
  _RoutmakeingscreenState createState() => _RoutmakeingscreenState();
}

class _RoutmakeingscreenState extends State<Routmakeingscreen> {
  final List<Machine> _machines = [
    Machine(name: 'Cutting', setups: ['45', '90', '77']),
    Machine(name: 'Drilling', setups: ['3', '8', '10', '14', '7']),
    Machine(name: 'Welding'),
    Machine(name: 'Grinding'),
  ];

  void _showCuttingSetupDialog(Machine machine) {
    showDialog(
      context: context,
      builder: (context) {
        return CuttingSetupDialog(
          options: machine.setups,
          onOptionSelected: (angle) {
            setState(() {
              machine.selectedSetup = angle; // Update the selected setup
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CustomPaint(
                  painter: DottedPainter(),
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 11,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _machines.map((machine) {
                        return GestureDetector(
                          onTap: () {
                            if (machine.setups != null) {
                              _showCuttingSetupDialog(machine);
                            }
                          },
                          child: MyDraggableWidget(data: machine),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      right: 60,
                      top: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E3E3E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: MyDropRegion(),
          ),
        ],
      ),
    );
  }
}
