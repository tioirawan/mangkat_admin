import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/models/switching_area_model.dart';
import 'switching_area_free_fleets_provider.dart';
import 'switching_areas_provider.dart';

/// Return available fleets for a route
final routeFreeFleetsProvider = Provider.autoDispose
    .family<Map<String, List<FleetModel>>, String?>((ref, routeId) {
  if (routeId == null) return {};

  List<SwitchingAreaModel> switchingAreas =
      ref.watch(switchingAreasProvider).value ?? [];

  switchingAreas = switchingAreas
      .where((switchingArea) => switchingArea.routes?.contains(routeId) == true)
      .toList();

  final Map<String, List<FleetModel>> availableFleets = {};

  for (final switchingArea in switchingAreas) {
    if (switchingArea.id == null) continue;

    final fleets = ref.watch(switchingAreaFreeFleetsProvider(switchingArea.id));

    availableFleets[switchingArea.id!] =
        fleets.where((fleet) => fleet.routeId == routeId).toList();
  }

  return availableFleets;
});

final switchingAreaAvailableFleetsByRouteProviderFlatten =
    Provider.autoDispose.family<List<FleetModel>, String?>((ref, routeId) {
  if (routeId == null) return [];

  final switchingAreaAvailableFleetsByRoute =
      ref.watch(routeFreeFleetsProvider(routeId));

  final List<FleetModel> fleets = [];

  for (final switchingAreaId in switchingAreaAvailableFleetsByRoute.keys) {
    fleets.addAll(switchingAreaAvailableFleetsByRoute[switchingAreaId] ?? []);
  }

  return fleets;
});
