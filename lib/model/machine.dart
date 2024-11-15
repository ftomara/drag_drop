class Machine {
  final String name;
  int? selectedSetup; // Optional setup angle
  List<String>? setups;
  Machine({required this.name, this.selectedSetup , this.setups});

  // A getter to get the display name based on setup
  String get displayName {
    return selectedSetup != null ? '$name (${selectedSetup}°)' : name;
  }
}
