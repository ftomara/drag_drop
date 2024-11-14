import 'package:drag_drop/model/raw_matrial.dart';
import 'package:drag_drop/widgets/dotted_bg.dart';
import 'package:drag_drop/widgets/raws_list.dart';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDropRegion extends StatefulWidget {
  @override
  _MyDropRegionState createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  // List to hold dropped items (widgets and their positions)
  List<_DraggableItemData> droppedItems = [];
  final List<RawMatrial> _rawMatrials = [
    RawMatrial(name: 'Aluminum', code: '54321'),
    RawMatrial(name: 'Copper', code: '768493'),
    RawMatrial(name: 'Steel', code: '93274'),
    RawMatrial(name: 'Titanium', code: '373499'),
  ];
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
                  _DraggableItemData(
                    position: localPosition,
                    value: value,
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
            Container(
              margin: const EdgeInsets.only(top: 100,left: 50),
              width: 200,
              child: RawsList(list: _rawMatrials),
            ),
            for (var item in droppedItems)
              Positioned(
                left: item.position.dx,
                top: item.position.dy,
                child: _DraggableItem(
                  data: item,
                  onPositionChanged: (newPosition) {
                    setState(() {
                      item.position = newPosition;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DraggableItemData {
  Offset position;
  final String value;

  _DraggableItemData({required this.position, required this.value});
}

class _DraggableItem extends StatelessWidget {
  final _DraggableItemData data;
  final Function(Offset) onPositionChanged;

  const _DraggableItem({
    required this.data,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Update position based on drag
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
