
import 'dart:ui';

class DraggableItemData {
  Offset position;
  final String machine_name_setup;
  final int? id;
  DraggableItemData({required this.position, required this.machine_name_setup, this.id});
  Map<String, dynamic> toJson() {
    return {
      'position': {'dx': position.dx, 'dy': position.dy},
      'machine_name_setup': machine_name_setup,
      'id': id,
    };
  }

  // Factory method to create an instance from a JSON map
  factory DraggableItemData.fromJson(Map<String, dynamic> json) {
    return DraggableItemData(
      position: Offset(json['position']['dx'], json['position']['dy']),
      machine_name_setup: json['machine_name_setup'],
      id: json['id'],
    );
  }
}