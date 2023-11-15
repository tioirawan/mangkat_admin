import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/switching_area_model.dart';
import '../../domain/repositories/switching_area_repository.dart';

class SwitchingAreaRepositoryImpl implements SwitchingAreaRepository {
  final FirebaseFirestore _firestore;

  SwitchingAreaRepositoryImpl(this._firestore);

  CollectionReference get _switchingAreas =>
      _firestore.collection('switching_areas');

  @override
  Future<SwitchingAreaModel> addSwitchingArea(
    SwitchingAreaModel switchingArea,
  ) async {
    final doc = await _switchingAreas.add(switchingArea.toDocument());

    return switchingArea.copyWith(
      id: doc.id,
      reference: doc,
    );
  }

  @override
  Future<void> deleteSwitchingArea(SwitchingAreaModel switchingArea) async {
    await _switchingAreas.doc(switchingArea.id).delete();
  }

  @override
  Future<SwitchingAreaModel> getSwitchingArea(String id) async {
    final snapshot = await _switchingAreas.doc(id).get();
    return SwitchingAreaModel.fromSnapshot(snapshot);
  }

  @override
  Future<List<SwitchingAreaModel>> getSwitchingAreas() async {
    final snapshot = await _switchingAreas.get();
    return snapshot.docs
        .map((e) => SwitchingAreaModel.fromSnapshot(e))
        .toList();
  }

  @override
  Future<SwitchingAreaModel> update(
    SwitchingAreaModel switchingArea,
  ) async {
    await _switchingAreas
        .doc(switchingArea.id)
        .update(switchingArea.toDocument());

    return switchingArea;
  }

  @override
  Stream<List<SwitchingAreaModel>> streamSwitchingAreas() {
    return _switchingAreas.snapshots().map(
          (snapshot) =>
              snapshot.docs.map(SwitchingAreaModel.fromSnapshot).toList(),
        );
  }

  @override
  Stream<SwitchingAreaModel> streamSwitchingArea(String id) {
    return _switchingAreas.doc(id).snapshots().map(
          (snapshot) => SwitchingAreaModel.fromSnapshot(snapshot),
        );
  }
}
