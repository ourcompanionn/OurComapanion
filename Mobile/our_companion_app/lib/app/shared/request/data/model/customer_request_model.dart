class RequestModel {
  final String pickupLocation;
  final String destination;
  final String requestType;
  final bool withVehicle;
  final DateTime? scheduleTime;

  RequestModel({
    required this.pickupLocation,
    required this.destination,
    required this.requestType,
    required this.withVehicle,
    this.scheduleTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "pickupLocation": pickupLocation,
      "destination": destination,
      "requestType": requestType,
      "withVehicle": withVehicle,
      "scheduleTime": scheduleTime?.toIso8601String(),
    };
  }
}
