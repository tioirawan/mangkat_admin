import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/models/fleet_position_model.dart';
import '../domain/models/route_model.dart';
import 'providers/common/content_window_controller/content_window_controller.dart';
import 'providers/common/map_controller/map_provider.dart';
import 'providers/common/sections/sidebar_content_controller.dart';
import 'providers/fleet/fleets_position_provider.dart';
import 'providers/fleet/focused_fleet_provider.dart';
import 'providers/route/edited_route_provider.dart';
import 'providers/route/focused_route_provider.dart';
import 'providers/route/routes_filtered_provider.dart';
import 'windows/sidebars/fleet_detail_window.dart';

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFleetIcon();
    });
  }

  BitmapDescriptor _fleetIcon = BitmapDescriptor.defaultMarker;

  Future<void> _loadFleetIcon() async {
    _fleetIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size.square(28),
      ),
      'assets/images/fleet_position_marker.png',
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapControllerProvider);
    final routes = ref.watch(routeFilteredProvider);
    final fleetsPosition = ref.watch(fleetsPositionProvider);
    final focusedRoute = ref.watch(focusedRouteProvider);
    final focusedFleet = ref.watch(focusedFleetProvider);
    final editedRoute = ref.watch(editedRouteProvider);

    print('fleetPosition: ${fleetsPosition.asData?.value}');

    Set<Polyline> polylines = state.polylines;
    Set<Marker> markers = state.markers;

    ref.listen(fleetsPositionProvider, (_, state) {
      final positions = state.value ?? {};

      if (focusedFleet == null) return;

      FleetPositionModel? position;

      for (final fleetId in positions.keys) {
        if (fleetId == focusedFleet.id) {
          position = positions[fleetId];
          break;
        }
      }

      if (position == null) return;

      ref.read(mapControllerProvider.notifier).animateCamera(
            CameraUpdate.newLatLng(
              LatLng(
                position.latitude ?? 0,
                position.longitude ?? 0,
              ),
            ),
          );
    });

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

      for (MapEntry<String, FleetPositionModel> entry
          in fleetsPosition.asData?.value.entries ?? []) {
        final fleetPosition = entry.value;

        final marker = Marker(
          markerId: MarkerId('fleet_${entry.key}'),
          position: LatLng(
            fleetPosition.latitude ?? 0,
            fleetPosition.longitude ?? 0,
          ),
          icon: _fleetIcon,
          // icon: BitmapDescriptor.defaultMarkerWithHue(
          //   BitmapDescriptor.hueAzure,
          // ),
          // rotation: 90,
          anchor: const Offset(0.5, 0.5),
          zIndex: 2,
          onTap: () {
            // ref.read(focusedRouteProvider.notifier).state = null;

            ref
                .read(rightSidebarContentController.notifier)
                .open(FleetDetailWindow.name, entry.key);
          },
        );

        markers = {
          ...markers,
          marker,
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
        markers: markers,
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
