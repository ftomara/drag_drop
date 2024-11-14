import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDropRegion extends StatefulWidget {
  @override
  _MyDropRegionState createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  // List to hold dropped items (widgets)
  List<Widget> droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (event) {
        final item = event.session.items.first;
        if (item.canProvide(Formats.plainText)) {
          return DropOperation.copy;
        }
        return DropOperation.none;
      },
      onPerformDrop: (event) async {
        final item = event.session.items.first;
        final reader = item.dataReader!;
        if (reader.canProvide(Formats.plainText)) {
          reader.getValue<String>(Formats.plainText, (value) {
            if (value != null) {
              setState(() {
                // Add the dropped container to the list of dropped items
                droppedItems.add(
                  Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.blueAccent,
                    child: Center(child: Text(value, style: TextStyle(color: Colors.white))),
                  ),
                );
              });
            }
          }, onError: (error) {
            print('Error reading value $error');
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.grey[200],
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,  // Allow horizontal scrolling
          child: Row(
            children: droppedItems,  // Display dropped items in a row
          ),
        ),
      ),
    );
  }
}
