import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/fleet_position_repository_impl.dart';
import '../models/fleet_position_model.dart';
import '../services/firebase_service.dart';

final fleetPositionRepositoryProvider = Provider<FleetPositionRepository>(
  (ref) => FleetPositionRepositoryImpl(ref.watch(databaseProvider)),
);

abstract class FleetPositionRepository {
  Future<FleetPositionModel?> getFleetPosition(String fleetId);
  Stream<FleetPositionModel?> getFleetPositionStream(String fleetId);
  Stream<Map<String, FleetPositionModel>> getFleetsPositionStream();
}
