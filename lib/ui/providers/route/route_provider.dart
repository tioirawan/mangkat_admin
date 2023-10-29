import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import 'routes_provider.dart';

/// Provides the route with the given [routeId].
final routeProvider =
    StateProvider.family<RouteModel?, String?>((ref, routeId) {
  final routeState = ref.watch(routesProvider);

  if (routeId == null || routeState is AsyncLoading) {
    return null;
  }

  final List<RouteModel> routes = routeState.maybeWhen(
    data: (routes) => routes,
    orElse: () => [],
  );

  RouteModel? route;

  for (final r in routes) {
    if (r.id == routeId) {
      route = r;
      break;
    }
  }

  return route;
});
