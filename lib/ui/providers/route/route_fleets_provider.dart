import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/models/route_model.dart';
import '../fleet/fleets_provider.dart';

// TODO: test .autoDispose
final routeFleetNumberProvider =
    StateProvider.family<List<FleetModel>, RouteModel?>((ref, route) {
  final fleetsState = ref.watch(fleetsProvider);
  final List<FleetModel> fleets = fleetsState.maybeWhen(
    data: (fleets) => fleets,
    orElse: () => [],
  );

  if (route == null) {
    return [];
  }

  return fleets.where((fleet) => fleet.routeId == route.id).toList();
});
