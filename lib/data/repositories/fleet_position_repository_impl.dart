import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/models/fleet_position_model.dart';
import '../../domain/repositories/fleet_position_repository.dart';

class FleetPositionRepositoryImpl implements FleetPositionRepository {
  final FirebaseDatabase _database;

  FleetPositionRepositoryImpl(this._database);

  DatabaseReference get _ref => _database.ref('fleet_positions');

  @override
  Future<FleetPositionModel?> getFleetPosition(String fleetId) async {
    final snapshot = await _ref.child(fleetId).get();

    if (snapshot.value == null) {
      return null;
    }

    final fleetPosition = FleetPositionModel.fromJson(
      snapshot.value as Map<String, dynamic>,
    );

    return fleetPosition;
  }

  @override
  Stream<FleetPositionModel?> getFleetPositionStream(String fleetId) {
    return _ref.child(fleetId).onValue.map((event) {
      if (event.snapshot.value == null) {
        return null;
      }

      final fleetPosition = FleetPositionModel.fromJson(
        event.snapshot.value as Map<String, dynamic>,
      );

      return fleetPosition;
    });
  }

  @override
  Stream<Map<String, FleetPositionModel>> getFleetsPositionStream() {
    return _ref.onValue.map((event) {
      final Map<String, FleetPositionModel> fleetPositions = {};

      if (event.snapshot.value == null) {
        return fleetPositions;
      }

      final Map<String, dynamic> data =
          event.snapshot.value as Map<String, dynamic>;

      data.forEach((key, value) {
        fleetPositions[key] =
            FleetPositionModel.fromJson(value as Map<String, dynamic>);
      });

      return fleetPositions;
    }).throttleTime(const Duration(seconds: 1));
  }
}
