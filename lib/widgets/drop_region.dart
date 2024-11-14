import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDropRegion extends StatefulWidget {
  @override
  _MyDropRegionState createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  // List to hold dropped items (widgets)
  List<Widget> droppedItems = [];
  List<Offset> dropPositions = [];
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
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(event.position.local);

            if (value != null) {
              setState(() {
                // Add the dropped container to the list of dropped items
                droppedItems.add(
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.transparent,
                    ),
                    child: Center(
                        child: Text(value,
                            style: const TextStyle(color: Colors.black))),
                  ),
                );
                dropPositions.add(localPosition);
              });
            }
          }, onError: (error) {
            print('Error reading value $error');
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15.0),
        color: Colors.grey[200],
        child: Stack(
          children: [
            for (int i = 0; i < droppedItems.length; i++)
              Positioned(
                left: dropPositions[i].dx,
                top: dropPositions[i].dy,
                child: droppedItems[i],
              ),
          ],
        ),
      ),
    );
  }
}
