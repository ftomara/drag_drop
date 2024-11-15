import 'package:flutter/material.dart';

class DraggableItemData {
  Offset position;
  final String value;

  DraggableItemData({required this.position, required this.value});
}

class DraggableItem extends StatelessWidget {
  final DraggableItemData data;
  final Function(Offset) onPositionChanged;
  final VoidCallback onDelete;

  const DraggableItem({
    required this.data,
    required this.onPositionChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        onDelete();
      },
      onPanUpdate: (details) {
        onPositionChanged(data.position + details.delta);
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(data.value, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
