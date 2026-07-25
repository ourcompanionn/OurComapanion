import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/location_controller.dart';

class CurrentLocationMap extends ConsumerWidget {
  const CurrentLocationMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationControllerProvider);

    return location.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),

      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),

      data: (data) {
        final current = LatLng(
          data.latitude,
          data.longitude,
        );

        return FlutterMap(
          options: MapOptions(
            initialCenter: current,
            initialZoom: 16,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.our_companion_app',
            ),

            MarkerLayer(
              markers: [
                Marker(
                  point: current,
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 45,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}