import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import '../filter/filter_provider.dart';
import 'routes_provider.dart';

final routeFilteredProvider = StateProvider<List<RouteModel>>((ref) {
  final routesState = ref.watch(routesProvider);
  final routeFilter = ref.watch(routeFilterProvider);

  final routes = routesState.asData?.value ?? [];

  if (routeFilter.isEmpty) {
    return routes;
  }

  final filteredRoutes = routes.where((route) {
    return routeFilter.contains(route.id);
  }).toList();

  return filteredRoutes;
});
