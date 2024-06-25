import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_position_model.dart';
import 'fleets_position_provider.dart';

final fleetPositionProvider =
    Provider.family<FleetPositionModel?, String?>((ref, fleetId) {
  if (fleetId == null) {
    return null;
  }

  // too expensive
  // return ref
  //     .watch(fleetPositionRepositoryProvider)
  //     .getFleetPositionStream(fleetId);

  final fleetsPosition = ref.watch(fleetsPositionProvider).asData?.value;

  if (fleetsPosition == null) {
    return null;
  }

  return fleetsPosition[fleetId];
});
