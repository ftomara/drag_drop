import 'package:drag_drop/model/connection.dart';
import 'package:drag_drop/model/draggable_item_data.dart';
import 'package:drag_drop/widgets/connection.dart';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import '../model/raw_matrial.dart';
import 'dotted_bg.dart';
import 'draggable_item.dart';
import 'raws_list.dart';

class MyDropRegion extends StatefulWidget {
  MyDropRegion({super.key, this.connections, this.droppedItems});
  List<DraggableItemData>? droppedItems;
  List<Connection>? connections;

  @override
  _MyDropRegionState createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  List<DraggableItemData> droppedItems = [];
  final List<RawMatrial> _rawMatrials = [
    RawMatrial(name: 'Aluminum', code: '54321'),
    RawMatrial(name: 'Copper', code: '768493'),
    RawMatrial(name: 'Steel', code: '93274'),
    RawMatrial(name: 'Titanium', code: '373499'),
  ];
  List<Connection> connections = [];
  int itemCounter = 0;
  DraggableItemData? selectedItem;

  @override
  initState() {
    super.initState();
    if (widget.connections != null) {
      connections = widget.connections!;
    }
    if (widget.droppedItems != null) {
      droppedItems = widget.droppedItems!;
    }
  }

  Future<void> showAreYouSureDialog(DraggableItemData item) async {
    bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF3E3E3E),
          title: const Text(
            'Delete Machine?',
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm deletion
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 189, 20, 8),
                ),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel deletion
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 36, 123, 5),
                ),
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (shouldDelete == true) {
      setState(() {
        droppedItems.remove(item);
        connections.removeWhere((connection) =>
            connection.startId == item.id || connection.endId == item.id);
      });
    }
  }

  void addConnection(int startId, int endId) {
    setState(() {
      connections.add(Connection(startId: startId, endId: endId));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                droppedItems.add(
                  DraggableItemData(
                    position: localPosition,
                    machine_name_setup: value,
                    id: ++itemCounter,
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
        width: width,
        height: height,
        color: Colors.grey[200],
        child: Stack(
          children: [
            CustomPaint(
              painter: DottedPainter(),
              size: Size(width, height),
            ),
            CustomPaint(
              painter:
                  LinePainter(connections: connections, items: droppedItems),
              size: Size(width, height),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 50),
              width: 200,
              child: RawsList(list: _rawMatrials),
            ),
            for (var item in droppedItems)
              Positioned(
                left: item.position.dx,
                top: item.position.dy,
                child: GestureDetector(
                  onTap: () {
                    if (selectedItem == null) {
                      selectedItem = item;
                    } else {
                      if (selectedItem!.id != item.id) {
                        addConnection(selectedItem!.id!, item.id!);
                      }
                      selectedItem = null;
                    }
                  },
                  child: DraggableItem(
                    data: item,
                    onPositionChanged: (newPosition) {
                      setState(() {
                        item.position = newPosition;
                      });
                    },
                    onDelete: () => showAreYouSureDialog(item),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
