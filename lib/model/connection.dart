class Connection {
  final int startId;
  final int endId;

  Connection({required this.startId, required this.endId});

  Map<String, dynamic> toJson() {
    return {
      'startId': startId,
      'endId': endId,
    };
  }

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      startId: json['startId'],
      endId: json['endId'],
    );
  }
}
