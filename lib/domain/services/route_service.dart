import 'package:flutter_polyline_no_xmlhttperror/flutter_polyline_no_xmlhttperror.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:latlong2/latlong.dart';

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
      final a = gmap.LatLng(origin.latitude, origin.longitude);
      final b = gmap.LatLng(destination.latitude, destination.longitude);

      List<gmap.LatLng> result =
          await _polylinePoints.getRouteBetweenCoordinates(a, b);

      return result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    } on Exception {
      return [];
    }
  }
}
