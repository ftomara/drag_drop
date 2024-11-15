import 'package:drag_drop/widgets/draggable_item.dart';
import 'package:flutter/material.dart';

class Connection {
  final int startId;
  final int endId;

  Connection({required this.startId, required this.endId});
}

class LinePainter extends CustomPainter {
  final List<Connection> connections;
  final List<DraggableItemData> items;

  LinePainter({required this.connections, required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (var connection in connections) {
      final startItem =
          items.firstWhere((item) => item.id == connection.startId);
      final endItem = items.firstWhere((item) => item.id == connection.endId);

      canvas.drawLine(
        startItem.position + const Offset(100, 25), // Center of the draggable item
        endItem.position + const Offset(0, 25), // Center of the draggable item
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
