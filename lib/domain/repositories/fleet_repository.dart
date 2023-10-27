import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/fleet_repository_impl.dart';
import '../models/fleet_model.dart';
import '../services/firebase_service.dart';

abstract class FleetRepository {
  Stream<List<FleetModel>> fleetsStream();
  Future<List<FleetModel>> getFleets();
  Future<FleetModel> getFleet(String id);
  Future<FleetModel> createFleet(FleetModel fleet, [Uint8List? image]);
  Future<FleetModel> updateFleet(FleetModel fleet, [Uint8List? image]);
  Future<void> deleteFleet(FleetModel fleet);
}

final fleetRepositoryProvider = Provider<FleetRepository>(
  (ref) => FleetRepositoryImpl(
    ref.watch(firestoreProvider),
    ref.watch(storageProvider),
  ),
);
