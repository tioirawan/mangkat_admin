import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../route/routes_filtered_provider.dart';

/// Provides the current map bounds
final mapBoundProvider = Provider<LatLngBounds>((ref) {
  final routes = ref.watch(routeFilteredProvider);

  final List<LatLng> points = [];

  for (final route in routes) {
    if (route.checkpoints == null) {
      continue;
    }

    points.addAll(route.checkpoints!);
  }

  final defaultBounds = LatLngBounds.fromPoints(points);

  if (points.isEmpty) {
    return defaultBounds;
  }

  return defaultBounds;
});
