import 'package:flutter_map/flutter_map.dart';

class MapState {
  final Map<String, Marker> markers;
  final Map<String, Polyline> polylines;
  final Map<String, CircleMarker> circles;
  final bool cleanMode;

  const MapState({
    this.markers = const {},
    this.polylines = const {},
    this.circles = const {},
    this.cleanMode = false,
  });

  // copy with method
  MapState copyWith({
    Map<String, Marker>? markers,
    Map<String, Polyline>? polylines,
    Map<String, CircleMarker>? circles,
    bool? cleanMode,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      circles: circles ?? this.circles,
      cleanMode: cleanMode ?? this.cleanMode,
    );
  }
}
