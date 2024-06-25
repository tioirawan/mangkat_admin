import 'package:flutter_map/flutter_map.dart';

class MapState {
  final Map<String, Marker> markers;
  final Map<String, Polyline> polylines;
  final bool cleanMode;

  const MapState({
    this.markers = const {},
    this.polylines = const {},
    this.cleanMode = false,
  });

  // copy with method
  MapState copyWith({
    Map<String, Marker>? markers,
    Map<String, Polyline>? polylines,
    bool? cleanMode,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      cleanMode: cleanMode ?? this.cleanMode,
    );
  }
}
