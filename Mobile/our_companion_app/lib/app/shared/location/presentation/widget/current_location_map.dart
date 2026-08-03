import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/route_controller.dart';
import 'package:our_companion_app/app/shared/location/presentation/providers/location_provider.dart';
import 'package:our_companion_app/app/shared/location/presentation/widget/current_location_marker.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/constents/maptiler.dart';
import 'package:our_companion_app/core/providers/theme_provider.dart';

import '../controllers/location_controller.dart';

class CurrentLocationMap extends ConsumerStatefulWidget {
  const CurrentLocationMap({super.key});

  @override
  ConsumerState<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends ConsumerState<CurrentLocationMap> {
  late final ProviderSubscription _routeSubscription;

  @override
  void initState() {
    super.initState();



 _routeSubscription = ref.listenManual(
  routeControllerProvider,
  (previous, next) {
    switch (next) {
      case AsyncData(value: final route):
        if (route == null) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          final mapController = ref.read(mapControllerProvider);

          mapController.fitCamera(
            CameraFit.coordinates(
              coordinates: route.points,
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
                top: 80,
                bottom: 250,
              ),
            ),
          );
        });

      default:
        break;
    }
  },


);
  }

  @override
  void dispose() {
    _routeSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationControllerProvider);
    final mapState = ref.watch(mapLocationProvider);
    final route = ref.watch(routeControllerProvider);
    final mapController = ref.watch(mapControllerProvider);


    return location.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stack) => Center(child: Text(error.toString())),

      data: (data) {
        final current = LatLng(data.latitude, data.longitude);
        final isDark = ref.watch(themeProvider) == ThemeMode.dark;
        final appColors = ref.watch(appColorsProvider);

        return FlutterMap(
          mapController: mapController,

          options: MapOptions(
            initialCenter: current,
            initialZoom: 16,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [     
            TileLayer(
              urlTemplate: isDark ? MapTiler.dark : MapTiler.styleLight,
              userAgentPackageName: 'com.example.our_companion_app',
            ),

            route.when(
              data: (routeData) {
                print("Polyline points = ${routeData?.points.length}");
                if (routeData == null) {
                  return const SizedBox.shrink();
                }

                return PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeData.points,
                      strokeWidth: 3,
                      color: appColors.secondary,
                    ),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, stack) {
                print("ROUTE PROVIDER ERROR: $error");
                print(stack);
                return const SizedBox.shrink();
              },
            ),

            MarkerLayer(
              markers: [
                // Current Location
                Marker(
                  point: current,
                  width: 40,
                  height: 40,
                  child: CurrentLocationMarker(),
                ),

                // Pickup Marker
                if (mapState.pickup != null)
                  Marker(
                    point: mapState.pickup!,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.circle,
                      weight: 900,
                      color: appColors.primary,
                      size: 20,
                    ),
                  ),

                // Destination Marker
                if (mapState.destination != null)
                  Marker(
                    point: mapState.destination!,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_pin,
                      color: appColors.primary,
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
