import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_state.dart';

final mapControllerProvider =
    StateNotifierProvider<MapControllerNotifier, MapState>(
  (ref) => MapControllerNotifier(),
);

class MapControllerNotifier extends StateNotifier<MapState> {
  MapControllerNotifier() : super(const MapState());

  GoogleMapController? _googleMapController;
  GoogleMapController? get controller => _googleMapController;

  // tap stream
  final StreamController<LatLng> _tapController =
      StreamController<LatLng>.broadcast();
  Stream<LatLng> get tapStream => _tapController.stream;

  void onTap(LatLng latLng) {
    _tapController.add(latLng);
  }

  void setGoogleMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void requestFocus() {
    state = state.copyWith(isFocus: true);
  }

  void removeFocus() {
    state = state.copyWith(isFocus: false);
  }

  void addMarker(Marker marker) {
    state = state.copyWith(markers: {...state.markers, marker});
  }

  void addPolyline(Polyline polyline) {
    state = state.copyWith(polylines: {...state.polylines, polyline});
  }

  void animateCamera(CameraUpdate cameraUpdate) {
    controller?.animateCamera(cameraUpdate);
  }

  void removePolyline(PolylineId polylineId) {
    state = state.copyWith(
      polylines: state.polylines.where((polyline) {
        return polyline.polylineId != polylineId;
      }).toSet(),
    );
  }

  void removeMarker(MarkerId markerId) {
    state = state.copyWith(
      markers: state.markers.where((marker) {
        return marker.markerId != markerId;
      }).toSet(),
    );

    print(state.markers);
  }

  @override
  void dispose() {
    _tapController.close();
    super.dispose();
  }
}
