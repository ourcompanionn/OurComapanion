import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:our_companion_app/app/shared/location/presentation/providers/location_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/constents/maptiler.dart';

import '../controllers/location_controller.dart';

class CurrentLocationMap extends ConsumerWidget {
  const CurrentLocationMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationControllerProvider);
    final mapState = ref.watch(mapLocationProvider);
    

    return location.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stack) => Center(child: Text(error.toString())),

      data: (data) {
        final current = LatLng(data.latitude, data.longitude);
        final isDart = Theme.of(context).brightness == Brightness.dark;
        final  appColors = ref.watch(appColorsProvider);

        return FlutterMap(
          options: MapOptions(initialCenter: current, initialZoom: 16),
          children: [
            TileLayer(
              urlTemplate: isDart ? MapTiler.dark : MapTiler.styleLight,
              userAgentPackageName: 'com.example.our_companion_app',
            ),

            MarkerLayer(
              markers: [
                // Current Location
                Marker(
                  point: current,
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),

                // Pickup Marker
                if (mapState.pickup != null)
                  Marker(
                    point: mapState.pickup!,
                    width: 50,
                    height: 50,
                    child:  Icon(
                      Icons.circle_outlined,
                      weight:900,
                      color: appColors.primary,
                      size: 25,
                    ),
                  ),

                // Destination Marker
                if (mapState.destination != null)
                  Marker(
                    point: mapState.destination!,
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
