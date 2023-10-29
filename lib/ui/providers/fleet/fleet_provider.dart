import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import 'fleets_provider.dart';

final fleetProvider = Provider.family<FleetModel?, String?>((ref, fleetId) {
  if (fleetId == null) {
    return null;
  }

  final fleets = ref.watch(fleetsProvider).asData?.value;

  if (fleets == null || fleets.isEmpty) {
    return null;
  }

  final filtered = fleets.where((fleet) => fleet.id == fleetId).toList();

  if (filtered.isEmpty) {
    return null;
  }

  return filtered.first;
});
