import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/fleet_occupancies_repository_impl.dart';
import '../services/firebase_service.dart';

abstract class FleetOccupanciesRepository {
  Future<int> getOccupancies(String fleetId);
  Stream<int> getOccupanciesStream(String fleetId);
  Stream<Map<String, int>> geAllOccupanciesStreams();
}

final fleetOccupanciesRepositoryProvider = Provider<FleetOccupanciesRepository>(
  (ref) => FleetOccupanciesRepositoryImpl(ref.watch(databaseProvider)),
);
