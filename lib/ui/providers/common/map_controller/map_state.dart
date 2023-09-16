import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const MapState({
    this.markers = const {},
    this.polylines = const {},
  });

  // copy with method
  MapState copyWith({
    Set<Marker>? markers,
    Set<Polyline>? polylines,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }
}
