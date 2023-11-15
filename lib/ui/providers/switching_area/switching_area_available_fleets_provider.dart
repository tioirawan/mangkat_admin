import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../helpers/map_helper.dart';
import '../fleet/fleets_occupancies_provider.dart';
import '../fleet/fleets_position_provider.dart';
import '../fleet/fleets_provider.dart';
import 'switching_area_provider.dart';

/// Provide fleets that are available to be switched to other route route
final switchingAreaAvailableFleetsProvider = Provider.autoDispose
    .family<List<FleetModel>, String?>((ref, switchingAreaId) {
  if (switchingAreaId == null) {
    return [];
  }

  final switchingArea = ref.watch(switchingAreaProvider(switchingAreaId));

  if (switchingArea == null) {
    return [];
  }

  final fleets = ref.watch(fleetsProvider).value ?? [];
  final fleetsPosition = ref.watch(fleetsPositionProvider).value ?? {};
  final fleetsPassanger = ref.watch(fleetsOccupanciesProvider).value ?? {};

  final availableFleets = fleets.where((fleet) {
    final isMatch = switchingArea.routes?.contains(fleet.routeId) == true &&
        fleet.driverId != null;

    if (!isMatch) return false;

    final passanger = fleetsPassanger[fleet.id];
    if (passanger == null || passanger > 0) return false;

    final position = fleetsPosition[fleet.id];
    if (position == null) return false;

    final isInRange = MapHelper.calculateDistance(
          switchingArea.latitude,
          switchingArea.longitude,
          position.latitude,
          position.longitude,
        ) <=
        switchingArea.radius!;

    return isInRange;
  }).toList();

  return availableFleets;
});
