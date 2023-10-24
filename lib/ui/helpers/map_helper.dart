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
}
