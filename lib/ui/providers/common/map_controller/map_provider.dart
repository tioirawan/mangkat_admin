import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'map_state.dart';

final mapControllerProvider =
    StateNotifierProvider<MapControllerNotifier, MapState>(
  (ref) => MapControllerNotifier(),
);

class MapControllerNotifier extends StateNotifier<MapState> {
  MapControllerNotifier() : super(const MapState());

  AnimatedMapController? _mapController;
  AnimatedMapController? get controller => _mapController;

  // tap stream
  final StreamController<LatLng> _tapController =
      StreamController<LatLng>.broadcast();
  Stream<LatLng> get tapStream => _tapController.stream;

  void onTap(LatLng latLng) {
    _tapController.add(latLng);
  }

  void setAnimatedMapController(AnimatedMapController controller) {
    _mapController = controller;
  }

  void requestFocus() {
    state = state.copyWith(cleanMode: true);
  }

  void removeFocus() {
    state = state.copyWith(cleanMode: false);
  }

  void addMarker(String key, Marker marker) {
    state = state.copyWith(markers: {...state.markers, key: marker});
  }

  void addPolyline(String key, Polyline polyline) {
    state = state.copyWith(polylines: {...state.polylines, key: polyline});
  }

  void addCircle(String key, CircleMarker circle) {
    state = state.copyWith(circles: {...state.circles, key: circle});
  }

  // void animateCamera(CameraUpdate cameraUpdate) {
  //   controller?.animateCamera(cameraUpdate);
  // }

  void animateTo(LatLng latLng, {double? zoom}) {
    controller?.animateTo(
      dest: latLng,
      zoom: zoom,
    );
  }

  void boundTo(LatLngBounds bounds, {EdgeInsets? padding}) {
    controller?.animatedFitBounds(
      bounds,
      options: padding != null ? FitBoundsOptions(padding: padding) : null,
    );
  }

  void removePolyline(String key) {
    state = state.copyWith(polylines: {
      for (final entry in state.polylines.entries)
        if (entry.key != key) entry.key: entry.value
    });
  }

  void removeMarker(String key) {
    state = state.copyWith(markers: {
      for (final entry in state.markers.entries)
        if (entry.key != key) entry.key: entry.value
    });
  }

  void removeCircle(String key) {
    state = state.copyWith(circles: {
      for (final entry in state.circles.entries)
        if (entry.key != key) entry.key: entry.value
    });
  }

  @override
  void dispose() {
    _tapController.close();
    super.dispose();
  }
}
