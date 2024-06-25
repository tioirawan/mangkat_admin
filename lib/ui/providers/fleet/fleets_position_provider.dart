import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_position_model.dart';
import '../../../domain/repositories/fleet_position_repository.dart';

final fleetsPositionProvider = StreamProvider<Map<String, FleetPositionModel>>(
  (ref) => ref.watch(fleetPositionRepositoryProvider).getFleetsPositionStream(),
);
