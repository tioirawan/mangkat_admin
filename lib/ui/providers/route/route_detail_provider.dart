import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fleet/fleets_occupancies_provider.dart';
import '../pick_requests/route_pick_requests_provide.dart';
import 'route_fleets_provider.dart';
import 'route_provider.dart';

class RouteDetail {
  final String routeId;
  final int totalFleets;
  final int totalPassengers;
  final int totalDriver;
  final int totalCapacity;
  final int totalPickupRequests;

  RouteDetail({
    required this.routeId,
    required this.totalFleets,
    required this.totalDriver,
    required this.totalPassengers,
    required this.totalCapacity,
    required this.totalPickupRequests,
  });
}

/// Return computed statistics of a route
final routeDetailProvider =
    Provider.autoDispose.family<RouteDetail?, String?>((ref, routeId) {
  if (routeId == null) {
    return null;
  }

  final route = ref.watch(routeProvider(routeId));
  final fleets = ref.watch(routeFleetsProvider(routeId));

  if (route == null) {
    return null;
  }

  final passangers = ref.watch(fleetsOccupanciesProvider);
  final pickRequests = ref.watch(routePickRequestsProvider(routeId));

  int totalPassangers = 0;

  int totalFleets = fleets.length;
  int totalDriver = fleets.where((fleet) => fleet.driverId != null).length ?? 0;

  for (final fleet in fleets) {
    totalPassangers += passangers.value?[fleet.id] ?? 0;
  }

  int totalCapacity = 0;

  for (final fleet in fleets) {
    totalCapacity += fleet.maxCapacity ?? 0;
  }

  int totalPickupRequests = pickRequests.value?.length ?? 0;

  return RouteDetail(
    routeId: routeId,
    totalFleets: totalFleets,
    totalDriver: totalDriver,
    totalPassengers: totalPassangers,
    totalCapacity: totalCapacity,
    totalPickupRequests: totalPickupRequests,
  );
});
