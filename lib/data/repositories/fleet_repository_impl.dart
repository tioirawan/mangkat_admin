import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/fleet_model.dart';
import '../../domain/repositories/fleet_repository.dart';

class FleetRepositoryImpl implements FleetRepository {
  final FirebaseFirestore _firestore;

  FleetRepositoryImpl(this._firestore);

  CollectionReference get _fleets => _firestore.collection('fleets');

  @override
  Stream<List<FleetModel>> fleetsStream() {
    return _fleets
        .snapshots()
        .map((snapshot) => snapshot.docs.map(FleetModel.fromSnapshot).toList());
  }

  @override
  Future<FleetModel> createFleet(FleetModel fleet) async {
    final doc = await _fleets.add(fleet.toDocument());
    return fleet.copyWith(
      id: fleet.id,
      reference: doc,
    );
  }

  @override
  Future<void> deleteFleet(FleetModel fleet) async {
    await _fleets.doc(fleet.id).delete();
  }

  @override
  Future<FleetModel> getFleet(String id) async {
    final snapshot = await _fleets.doc(id).get();
    return FleetModel.fromSnapshot(snapshot);
  }

  @override
  Future<List<FleetModel>> getFleets() async {
    final snapshot = await _fleets.get();
    return snapshot.docs.map((e) => FleetModel.fromSnapshot(e)).toList();
  }

  @override
  Future<FleetModel> updateFleet(FleetModel fleet) async {
    await _fleets.doc(fleet.id).update(fleet.toDocument());
    return fleet;
  }
}
