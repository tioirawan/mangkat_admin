import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../domain/models/fleet_model.dart';
import '../../domain/repositories/fleet_repository.dart';

class FleetRepositoryImpl implements FleetRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FleetRepositoryImpl(this._firestore, this._storage);

  CollectionReference get _fleets => _firestore.collection('fleets');
  Reference get _storageRef => _storage.ref('fleets');

  @override
  Stream<List<FleetModel>> fleetsStream() {
    return _fleets.snapshots().map(
          (snapshot) => snapshot.docs.map(FleetModel.fromSnapshot).toList()
            ..sort((a, b) {
              if (a.vehicleNumber == null || b.vehicleNumber == null) {
                return 0;
              }

              return a.vehicleNumber!.compareTo(b.vehicleNumber!);
            }),
        );
  }

  @override
  Future<FleetModel> createFleet(FleetModel fleet, [Uint8List? image]) async {
    final uid = _fleets.doc().id;

    if (image != null) {
      // only on web, on mobile, we use putFile
      final snapshot = await _storageRef.child('$uid.png').putData(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      fleet = fleet.copyWith(image: downloadUrl);
    }

    final doc = _fleets.doc(uid);

    await doc.set(fleet.copyWith(createdAt: DateTime.now()).toDocument());

    return fleet.copyWith(
      id: fleet.id,
      reference: doc,
    );
  }

  @override
  Future<void> deleteFleet(FleetModel fleet) async {
    // delete image
    if (fleet.image != null) {
      await _storage.refFromURL(fleet.image!).delete();
    }

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
  Future<FleetModel> updateFleet(FleetModel fleet, [Uint8List? image]) async {
    if (image != null) {
      final snapshot =
          await _storageRef.child('${fleet.id}.png').putData(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      fleet = fleet.copyWith(image: downloadUrl);
    }

    await _fleets
        .doc(fleet.id)
        .update(fleet.copyWith(updatedAt: DateTime.now()).toDocument());

    return fleet;
  }
}
