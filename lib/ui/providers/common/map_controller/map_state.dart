import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final bool isFocused;

  const MapState({
    this.markers = const {},
    this.polylines = const {},
    this.isFocused = false,
  });

  // copy with method
  MapState copyWith({
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    bool? isFocus,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      isFocused: isFocus ?? this.isFocused,
    );
  }
}
