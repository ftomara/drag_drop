import 'dart:async';

import 'package:drag_drop/model/machine.dart';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

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
        item.add(Formats.plainText(data.name));  
        return item;
      },
      allowedOperations: () => [DropOperation.copy],
      child: DraggableWidget(
        
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48 , vertical: 12),
          margin: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black , width: 2),
            color: Colors.transparent,

          ),
          child: Center(child: Text(data.name, style: const TextStyle(color: Colors.black))),
        ),
      ),
    );
  }
}
