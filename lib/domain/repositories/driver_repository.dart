import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/driver_repository_impl.dart';
import '../models/driver_model.dart';
import '../services/firebase_service.dart';

abstract class DriverRepository {
  Stream<List<DriverModel>> driversStream();
  Future<List<DriverModel>> getDrivers();
  Future<DriverModel> getDriver(String id);
  Future<DriverModel> createDriver(DriverModel driver, [Uint8List? image]);
  Future<DriverModel> updateDriver(DriverModel driver, [Uint8List? image]);
  Future<void> deleteDriver(DriverModel driver);
}

final driverRepositoryProvider = Provider<DriverRepository>(
  (ref) => DriverRepositoryImpl(
    ref.watch(firestoreProvider),
    ref.watch(storageProvider),
  ),
);
