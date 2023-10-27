import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/models/route_model.dart';
import 'providers/common/content_window_controller/content_window_controller.dart';
import 'providers/common/map_controller/map_provider.dart';
import 'providers/route/edited_route_provider.dart';
import 'providers/route/focused_route_provider.dart';
import 'providers/route/routes_filtered_provider.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-7.9726366, 112.6381682),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapControllerProvider);
    final routes = ref.watch(routeFilteredProvider);
    final focusedRoute = ref.watch(focusedRouteProvider);
    final editedRoute = ref.watch(editedRouteProvider);

    Set<Polyline> polylines = state.polylines;

    if (!state.cleanMode) {
      for (final RouteModel route in routes) {
        if (route.id == null ||
            route.routes == null ||
            route.color == null ||
            editedRoute?.id == route.id) {
          continue;
        }

        Color color = route.color ?? Colors.blue;
        int zIndex = 0;

        if (focusedRoute?.id != null && route.id != focusedRoute?.id) {
          color = color.withOpacity(0.5);
          zIndex = 1;
        }

        final polyline = Polyline(
          polylineId: PolylineId('route_${route.id!}'),
          points: route.routes ?? [],
          color: color,
          width: 4,
          zIndex: zIndex,
          onTap: () {
            ref.read(focusedRouteProvider.notifier).state = route;
            ref
                .read(contentWindowProvider.notifier)
                .show(ContentWindowType.routeManager);
          },
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
      padding: state.cleanMode ? const EdgeInsets.all(16) : EdgeInsets.zero,
      child: GoogleMap(
        trafficEnabled: false,
        cloudMapId: 'c92510ddc71ac5fc',
        initialCameraPosition: _initialCamera,
        markers: state.markers,
        polylines: polylines,
        onTap: (LatLng latLng) {
          // if (editedRoute == null && focusedRoute != null) {
          //   ref.read(focusedRouteProvider.notifier).state = null;
          // }

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
