import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/fleet_occupancies_repository.dart';

final fleetsOccupanciesProvider = StreamProvider.autoDispose<Map<String, int>>(
  (ref) =>
      ref.watch(fleetOccupanciesRepositoryProvider).geAllOccupanciesStreams(),
);
