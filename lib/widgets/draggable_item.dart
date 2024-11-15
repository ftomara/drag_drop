import 'package:drag_drop/model/draggable_item_data.dart';
import 'package:flutter/material.dart';


class DraggableItem extends StatelessWidget {
  final DraggableItemData data;
  final Function(Offset) onPositionChanged;
  final VoidCallback onDelete;

  const DraggableItem({
    super.key,
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
          child: Text(data.machine_name_setup, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
