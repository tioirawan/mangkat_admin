import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/driver_model.dart';
import '../../../domain/repositories/driver_repository.dart';

final driversProvider = StreamProvider<List<DriverModel>>(
  (ref) => ref.watch(driverRepositoryProvider).driversStream(),
);
