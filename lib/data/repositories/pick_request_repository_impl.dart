import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/pick_request_model.dart';
import '../../domain/repositories/pick_request_repository.dart';

class PickRequestRepositoryImpl implements PickRequestRepository {
  final FirebaseFirestore _firestore;

  PickRequestRepositoryImpl(
    this._firestore,
  );

  CollectionReference get _pickRequests =>
      _firestore.collection('pick_requests');

  @override
  Stream<List<PickRequestModel>> streamRoutePickRequests(String routeId) {
    return _pickRequests
        .where('route_id', isEqualTo: routeId)
        .where('picked', isEqualTo: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((e) => PickRequestModel.fromSnapshot(e))
              .toList(),
        );
  }

  @override
  Stream<List<PickRequestModel>> streamAllPickRequests() {
    return _pickRequests.where('picked', isEqualTo: false).snapshots().map(
          (snapshot) => snapshot.docs
              .map((e) => PickRequestModel.fromSnapshot(e))
              .toList(),
        );
  }
}
