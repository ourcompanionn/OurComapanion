
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location_model.dart';


abstract class LocationLocalDatasource {
  Future<LocationModel> getCurrentLocation();
}

class LocationLocalDatasourceImpl implements LocationLocalDatasource {
  @override
  Future<LocationModel> getCurrentLocation() async {
    // Check if location service is enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check permission
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied.");
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permission permanently denied. Please enable it from app settings.",
      );
    }

    // Get current GPS position
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    // Convert coordinates to address
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception("Unable to retrieve address.");
    }

    final place = placemarks.first;

    // Build a clean address without null values
    final address = [
      place.street,
      place.subLocality,
      place.locality,
    ].where((e) => e != null && e.trim().isNotEmpty).join(", ");

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
      locality: place.locality ?? "",
      subLocality: place.subLocality ?? "",
    );
  }
}