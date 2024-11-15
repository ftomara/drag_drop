import 'dart:async';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import '../model/machine.dart';
import 'custom_container.dart';

class MyDraggableWidget extends StatelessWidget {
  final Machine data;

  MyDraggableWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      dragItemProvider: (request) async {
        final item = DragItem(
          localData: {'data': data},
        );
        item.add(Formats.plainText(data.displayName));  // Use displayName
        return item;
      },
      allowedOperations: () => [DropOperation.copy],
      child: DraggableWidget(
        child: CustomContainer(text: data.displayName), // Use displayName here too
      ),
    );
  }
}
