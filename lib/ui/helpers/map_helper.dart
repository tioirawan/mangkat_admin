import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapHelper {
  static LatLngBounds? computeBounds(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }

    final firstLatLng = list.first;

    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;

    for (int i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }

    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  /// calculate distance bet two points in meters
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
