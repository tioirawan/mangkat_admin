import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/driver_model.dart';
import 'drivers_provider.dart';

final driverProvider = Provider.family<DriverModel?, String?>((ref, driverId) {
  final driversState = ref.watch(driversProvider);

  final drivers = driversState.asData?.value ?? [];

  DriverModel? driver;

  for (final d in drivers) {
    if (d.id == driverId) {
      driver = d;
      break;
    }
  }

  return driver;
});
