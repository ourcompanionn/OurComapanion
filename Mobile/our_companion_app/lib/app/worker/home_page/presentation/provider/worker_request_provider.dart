import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WorkerRequestStatus { incoming, accepted, empty }

class WorkerRequest {
  const WorkerRequest({
    required this.id,
    required this.customerName,
    required this.serviceName,
    required this.pickupLocation,
    required this.destination,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.earnings,
    required this.requestedAt,
  }); 

  final String id;
  final String customerName;
  final String serviceName;
  final String pickupLocation;
  final String destination;
  final double distanceKm;
  final int estimatedMinutes;
  final int earnings;
  final DateTime requestedAt;
}

class WorkerRequestState {
  const WorkerRequestState({required this.status, this.request});

  final WorkerRequestStatus status;
  final WorkerRequest? request;

  WorkerRequestState copyWith({
    WorkerRequestStatus? status,
    WorkerRequest? request,
    bool clearRequest = false,
  }) {
    return WorkerRequestState(
      status: status ?? this.status,
      request: clearRequest ? null : request ?? this.request,
    );
  }
}

class WorkerRequestNotifier extends Notifier<WorkerRequestState> {
  @override
  WorkerRequestState build() {
    // Replace this fixture with the worker's real-time request stream/API.
    return WorkerRequestState(
      status: WorkerRequestStatus.incoming,
      request: WorkerRequest(
        id: 'REQ-2048',
        customerName: 'Ananya Sharma',
        serviceName: 'Hospital Companion',
        pickupLocation: 'Koregaon Park, Pune',
        destination: 'Ruby Hall Clinic',
        distanceKm: 2.4,
        estimatedMinutes: 12,
        earnings: 320,
        requestedAt: DateTime.now(),
      ),
    );
  }

  void accept() => state = state.copyWith(status: WorkerRequestStatus.accepted);

  void decline() => state = state.copyWith(
        status: WorkerRequestStatus.empty,
        clearRequest: true,
      );

  void complete() => state = state.copyWith(
        status: WorkerRequestStatus.empty,
        clearRequest: true,
      );
}

final workerRequestProvider =
    NotifierProvider<WorkerRequestNotifier, WorkerRequestState>(
  WorkerRequestNotifier.new,
);
