import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/repositories/fleet_repository.dart';

final fleetsProvider = StreamProvider<List<FleetModel>>(
  (ref) => ref.watch(fleetRepositoryProvider).fleetsStream(),
);
