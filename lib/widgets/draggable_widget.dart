import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDraggableWidget extends StatelessWidget {
  final String data;  // Data for the draggable item

  MyDraggableWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      dragItemProvider: (request) async {
        final item = DragItem(
          localData: {'data': data},  // Store the data inside the drag item
        );
        item.add(Formats.plainText(data));  // Optionally add more data
        return item;
      },
      allowedOperations: () => [DropOperation.copy],
      child: DraggableWidget(
        child: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Colors.blueAccent,
          child: Center(child: Text(data, style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
