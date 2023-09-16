import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'providers/common/map_controller/map_provider.dart';

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

    return GoogleMap(
      trafficEnabled: false,
      cloudMapId: 'c92510ddc71ac5fc',
      initialCameraPosition: _initialCamera,
      markers: state.markers,
      polylines: state.polylines,
      onTap: (LatLng latLng) {
        ref.read(mapControllerProvider.notifier).onTap(latLng);
      },
      onMapCreated: (GoogleMapController controller) {
        ref
            .read(mapControllerProvider.notifier)
            .setGoogleMapController(controller);
      },
    );
  }
}
