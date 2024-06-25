import 'package:firebase_database/firebase_database.dart';

import '../../domain/repositories/fleet_occupancies_repository.dart';

class FleetOccupanciesRepositoryImpl implements FleetOccupanciesRepository {
  final FirebaseDatabase _database;

  FleetOccupanciesRepositoryImpl(this._database);

  DatabaseReference get _ref => _database.ref('fleet_occupancies');

  @override
  Future<int> getOccupancies(String fleetId) async {
    final snapshot = await _ref.child(fleetId).get();

    if (snapshot.value == null) {
      return 0;
    }

    final occupancies = snapshot.value as int?;

    return occupancies ?? 0;
  }

  @override
  Stream<int> getOccupanciesStream(String fleetId) {
    return _ref.child(fleetId).onValue.map((event) {
      if (event.snapshot.value == null) {
        return 0;
      }

      final occupancies = event.snapshot.value as int?;

      return occupancies ?? 0;
    });
  }
}
