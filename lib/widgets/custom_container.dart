import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.text});
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.transparent,
      ),
      child: Center(
          child: Text(text, style: const TextStyle(color: Colors.black))),
    );
  }
}
