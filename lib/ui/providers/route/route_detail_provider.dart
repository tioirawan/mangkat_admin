import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../fleet/fleets_occupancies_provider.dart';
import '../pick_requests/route_pick_requests_provide.dart';
import '../switching_area/route_free_fleets_provider.dart';
import 'route_fleets_provider.dart';
import 'route_provider.dart';

class RouteDetail {
  final String routeId;
  final int totalFleets;
  final int totalPassengers;
  final int totalDriver;
  final int totalCapacity;
  final int totalPickupRequests;
  final Map<String, List<FleetModel>> freeFleets;

  RouteDetail({
    required this.routeId,
    required this.totalFleets,
    required this.totalDriver,
    required this.totalPassengers,
    required this.totalCapacity,
    required this.totalPickupRequests,
    required this.freeFleets,
  });

  double get load {
    if (totalCapacity == 0) {
      return 0;
    }

    return totalPassengers / totalCapacity;
  }
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
  int totalDriver = fleets.where((fleet) => fleet.driverId != null).length;

  for (final fleet in fleets) {
    totalPassangers += passangers.value?[fleet.id] ?? 0;
  }

  int totalCapacity = 0;

  for (final fleet in fleets) {
    totalCapacity += fleet.maxCapacity ?? 0;
  }

  int totalPickupRequests = pickRequests.value?.length ?? 0;

  final freeFleets = ref.watch(routeFreeFleetsProvider(routeId));

  return RouteDetail(
    routeId: routeId,
    totalFleets: totalFleets,
    totalDriver: totalDriver,
    totalPassengers: totalPassangers,
    totalCapacity: totalCapacity,
    totalPickupRequests: totalPickupRequests,
    freeFleets: freeFleets,
  );
});
