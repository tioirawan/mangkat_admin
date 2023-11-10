import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../fleet/fleets_provider.dart';

// TODO: test .autoDispose
final routeFleetsProvider =
    StateProvider.autoDispose.family<List<FleetModel>, String?>((ref, routeId) {
  final fleetsState = ref.watch(fleetsProvider);
  final List<FleetModel> fleets = fleetsState.maybeWhen(
    data: (fleets) => fleets,
    orElse: () => [],
  );

  if (routeId == null) {
    return [];
  }

  return fleets.where((fleet) => fleet.routeId == routeId).toList();
});
