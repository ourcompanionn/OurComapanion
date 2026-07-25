import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';

class LocationFieldController extends ChangeNotifier {
  final Ref ref;
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final List<TextEditingController> stopControllers = [];

  LocationFieldController(this.ref) {
    final formState = ref.read(requestFormProvider);
    pickupController.text = formState.pickupLocation;
    destinationController.text = formState.destination;
    for (var stop in formState.stops) {
      stopControllers.add(TextEditingController(text: stop));
    }
  }

  void setPickup(String value) {
    ref.read(requestFormProvider.notifier).setPickupLocation(value);
  }

  void setDestination(String value) {
    ref.read(requestFormProvider.notifier).setDestination(value);
  }

  void addStop() {
    stopControllers.add(TextEditingController());
    ref.read(requestFormProvider.notifier).addStop();
    notifyListeners();
  }

  void updateStop(int index, String value) {
    ref.read(requestFormProvider.notifier).updateStop(index, value);
  }

  void removeStop(int index) {
    final controller = stopControllers.removeAt(index);
    controller.dispose();
    ref.read(requestFormProvider.notifier).removeStop(index);
    notifyListeners();
  }

  void setPickupLocation(String address) {
  pickupController.text = address;
  setPickup(address);
}

  @override
  void dispose() {
    pickupController.dispose();
    destinationController.dispose();
    for (var controller in stopControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

final locationFieldControllerProvider =
    ChangeNotifierProvider.autoDispose<LocationFieldController>((ref) {
      return LocationFieldController(ref);
    });
