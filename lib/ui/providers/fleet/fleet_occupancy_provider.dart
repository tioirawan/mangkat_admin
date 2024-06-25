import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/fleet_occupancies_repository.dart';

final fleetOccupancyProvider =
    StreamProvider.family<int, String?>((ref, fleetId) {
  if (fleetId == null) {
    return Stream.value(0);
  }

  return ref
      .watch(fleetOccupanciesRepositoryProvider)
      .getOccupanciesStream(fleetId);
});
