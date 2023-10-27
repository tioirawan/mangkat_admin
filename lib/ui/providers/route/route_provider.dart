import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import 'routes_provider.dart';

final routeProvider =
    StateProvider.family<RouteModel?, String?>((ref, routePath) {
  final routeState = ref.watch(routesProvider);

  final List<RouteModel> routes = routeState.maybeWhen(
    data: (routes) => routes,
    orElse: () => [],
  );

  RouteModel? route;

  for (final r in routes) {
    if (r.reference?.path == routePath) {
      route = r;
      break;
    }
  }

  return route;
});
