import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helpers/map_helper.dart';
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

  final defaultBounds = LatLngBounds(
    southwest: const LatLng(-7.9726366, 112.6381682),
    northeast: const LatLng(-7.9726366, 112.6381682),
  );

  if (points.isEmpty) {
    return defaultBounds;
  }

  return MapHelper.computeBounds(points) ?? defaultBounds;
});
