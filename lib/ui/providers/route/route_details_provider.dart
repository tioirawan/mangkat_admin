import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import 'route_detail_provider.dart';
import 'routes_provider.dart';

final routeDetailsProvider =
    Provider.autoDispose<Map<RouteModel, RouteDetail>>((ref) {
  final routes = ref.watch(routesProvider).value ?? [];

  final Map<RouteModel, RouteDetail> routesDetails = {};

  for (final route in routes) {
    routesDetails[route] = ref.watch(routeDetailProvider(route.id))!;
  }

  return routesDetails;
});
