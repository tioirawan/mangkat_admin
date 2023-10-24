import 'package:flutter_polyline_no_xmlhttperror/flutter_polyline_no_xmlhttperror.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final routeServiceProvider = Provider<RouteService>((ref) {
  const googleAPiKey = 'AIzaSyDbjkQSHEPm37DbLuICyGxXF0FjzkPxhXA';
  PolylinePoints polylinePoints = PolylinePoints(googleAPiKey);

  return RouteService(polylinePoints);
});

class RouteService {
  final PolylinePoints _polylinePoints;

  RouteService(this._polylinePoints);

  Future<List<LatLng>> getRouteBetweenCoordinates(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      List<LatLng> result =
          await _polylinePoints.getRouteBetweenCoordinates(origin, destination);

      return result;
    } on Exception {
      return [];
    }
  }
}
