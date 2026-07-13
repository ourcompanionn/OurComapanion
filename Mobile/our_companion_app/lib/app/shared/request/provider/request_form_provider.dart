import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/widgets.dart';

enum RequestType { instant, schedule }

class RequestFormState {
  final String pickupLocation;
  final String destination;
  final List<String> stops;
  final RequestType requestType;
  final DateTime? scheduleTime;
  final bool withVehicle;
  final String selectedService;
  final IconData? selectedServiceIcon;

  RequestFormState({
    this.pickupLocation = '',
    this.destination = '',
    this.stops = const [],
    this.requestType = RequestType.instant,
    this.scheduleTime,
    this.withVehicle = false,
    required this.selectedService,
    this.selectedServiceIcon,
  });

  RequestFormState copyWith({
    String? pickupLocation,
    String? destination,
    List<String>? stops,
    RequestType? requestType,
    DateTime? scheduleTime,
    bool? withVehicle,
    String? selectedService,
    IconData? selectedServiceIcon,
  }) {
    return RequestFormState(
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destination: destination ?? this.destination,
      stops: stops ?? this.stops,
      requestType: requestType ?? this.requestType,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      withVehicle: withVehicle ?? this.withVehicle,
      selectedService: selectedService ?? this.selectedService,
      selectedServiceIcon: selectedServiceIcon ?? this.selectedServiceIcon,
    );
  }
}

class RequestFormNotifier extends StateNotifier<RequestFormState> {
  RequestFormNotifier() : super(RequestFormState(selectedService: ''));

  void setPickupLocation(String location) {
    state = state.copyWith(pickupLocation: location);
  }

  void setDestination(String destination) {
    state = state.copyWith(destination: destination);
  }

  void addStop() {
    state = state.copyWith(stops: [...state.stops, '']);
  }

  void removeStop(int index) {
    final newStops = List<String>.from(state.stops)..removeAt(index);
    state = state.copyWith(stops: newStops);
  }

  void updateStop(int index, String value) {
    final newStops = List<String>.from(state.stops);
    newStops[index] = value;
    state = state.copyWith(stops: newStops);
  }

  void setRequestType(RequestType type) {
    state = state.copyWith(requestType: type);
  }

  void setScheduleTime(DateTime time) {
    state = state.copyWith(scheduleTime: time);
  }

  void setWithVehicle(bool withVehicle) {
    state = state.copyWith(withVehicle: withVehicle);
  }

  void setSelectedService(String service, {IconData? icon}) {
    state = state.copyWith(selectedService: service, selectedServiceIcon: icon);
  }
}

final requestFormProvider =
    StateNotifierProvider<RequestFormNotifier, RequestFormState>((ref) {
      return RequestFormNotifier();
    });
