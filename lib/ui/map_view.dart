import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/models/route_model.dart';
import 'providers/common/content_window_controller/content_window_controller.dart';
import 'providers/common/map_controller/map_provider.dart';
import 'providers/route/routes_provider.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-7.9726366, 112.6381682),
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapControllerProvider);
    final routes = ref.watch(routesProvider);

    Set<Polyline> polylines = state.polylines;

    if (!state.isFocused) {
      for (final RouteModel route in routes.asData?.value ?? []) {
        if (route.id == null || route.routes == null || route.color == null) {
          continue;
        }

        final polyline = Polyline(
          polylineId: PolylineId('route_${route.id!}'),
          points: route.routes ?? [],
          color: route.color ?? Colors.blue,
          width: 5,
          onTap: () => ref
              .read(contentWindowProvider.notifier)
              .toggle(ContentWindowType.routeManager),
        );

        polylines = {
          ...polylines,
          polyline,
        };
      }
    }

    return AnimatedContainer(
      duration: 200.milliseconds,
      curve: Curves.easeInOut,
      color: Theme.of(context).colorScheme.primary,
      padding: state.isFocused ? const EdgeInsets.all(16) : EdgeInsets.zero,
      child: GoogleMap(
        trafficEnabled: false,
        cloudMapId: 'c92510ddc71ac5fc',
        initialCameraPosition: _initialCamera,
        markers: state.markers,
        polylines: polylines,
        onTap: (LatLng latLng) {
          ref.read(mapControllerProvider.notifier).onTap(latLng);
        },
        onMapCreated: (GoogleMapController controller) {
          ref
              .read(mapControllerProvider.notifier)
              .setGoogleMapController(controller);
        },
      ),
    );
  }
}
