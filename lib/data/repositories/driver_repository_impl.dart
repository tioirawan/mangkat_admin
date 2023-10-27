import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/models/driver_model.dart';
import '../../domain/repositories/driver_repository.dart';

class DriverRepositoryImpl implements DriverRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  DriverRepositoryImpl(this._firestore, this._storage);

  CollectionReference get _drivers => _firestore.collection('drivers');
  Reference get _storageRef => _storage.ref('drivers');

  @override
  Stream<List<DriverModel>> driversStream() {
    return _drivers.snapshots().map(
          (snapshot) => snapshot.docs.map(DriverModel.fromSnapshot).toList()
            ..sort((a, b) {
              if (a.name == null || b.name == null) {
                return 0;
              }

              return a.name!.compareTo(b.name!);
            }),
        );
  }

  @override
  Future<DriverModel> createDriver(DriverModel driver,
      [Uint8List? image]) async {
    final uid = _drivers.doc().id;

    if (image != null) {
      // only on web, on mobile, we use putFile
      final snapshot = await _storageRef.child('$uid.png').putData(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      driver = driver.copyWith(image: downloadUrl);
    }

    final doc = _drivers.doc(uid);

    await doc.set(driver.copyWith(createdAt: DateTime.now()).toDocument());

    return driver.copyWith(
      id: driver.id,
      reference: doc,
    );
  }

  @override
  Future<void> deleteDriver(DriverModel driver) async {
    // delete image
    if (driver.image != null) {
      await _storage.refFromURL(driver.image!).delete();
    }

    await _drivers.doc(driver.id).delete();
  }

  @override
  Future<DriverModel> getDriver(String id) async {
    final snapshot = await _drivers.doc(id).get();

    return DriverModel.fromSnapshot(snapshot);
  }

  @override
  Future<List<DriverModel>> getDrivers() async {
    final snapshot = await _drivers.get();

    return snapshot.docs.map(DriverModel.fromSnapshot).toList();
  }

  @override
  Future<DriverModel> updateDriver(DriverModel driver,
      [Uint8List? image]) async {
    if (image != null) {
      // only on web, on mobile, we use putFile
      final snapshot =
          await _storageRef.child('${driver.id}.png').putData(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      driver = driver.copyWith(image: downloadUrl);
    }

    final doc = _drivers.doc(driver.id);

    await doc.update(driver.copyWith(updatedAt: DateTime.now()).toDocument());

    return driver.copyWith(
      id: driver.id,
      reference: doc,
    );
  }
}
