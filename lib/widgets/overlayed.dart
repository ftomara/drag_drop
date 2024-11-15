import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class Overlayed extends StatelessWidget {
  Overlayed({super.key, required this.child});
  final Widget child;
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, child) {
          return Transform(
            transform: notifier.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
