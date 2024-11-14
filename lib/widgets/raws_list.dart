import 'package:drag_drop/model/raw_matrial.dart';
import 'package:drag_drop/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class RawsList extends StatelessWidget {
  const RawsList({super.key, required this.list});
  final List<RawMatrial> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((item) {
        return CustomContainer(text: item.name);
      }).toList(),
    );
  }
}
