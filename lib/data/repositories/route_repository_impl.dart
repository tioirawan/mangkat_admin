import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/route_model.dart';
import '../../domain/repositories/route_repository.dart';

class RouteRepositoryImpl implements RouteRepository {
  final FirebaseFirestore _firestore;

  RouteRepositoryImpl(this._firestore);

  CollectionReference get _routes => _firestore.collection('routes');

  @override
  Stream<List<RouteModel>> routesStream() {
    return _routes
        .snapshots()
        .map((snapshot) => snapshot.docs.map(RouteModel.fromSnapshot).toList());
  }

  @override
  Future<void> addRoute(RouteModel route) async {
    await _routes.add(route.toDocument());
  }

  @override
  Future<void> deleteRoute(RouteModel route) async {
    await _routes.doc(route.id).delete();
  }

  @override
  Future<RouteModel> getRoute(String id) async {
    final snapshot = await _routes.doc(id).get();
    return RouteModel.fromSnapshot(snapshot);
  }

  @override
  Future<List<RouteModel>> getRoutes() async {
    final snapshot = await _routes.get();
    return snapshot.docs.map((e) => RouteModel.fromSnapshot(e)).toList();
  }

  @override
  Future<void> updateRoute(RouteModel route) async {
    await _routes.doc(route.id).update(route.toDocument());
  }
}
