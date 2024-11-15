
import 'package:flutter/material.dart';

import '../model/raw_matrial.dart';
import 'custom_container.dart';

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
