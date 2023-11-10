import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/route_model.dart';
import '../../domain/repositories/route_repository.dart';

class RouteRepositoryImpl implements RouteRepository {
  final FirebaseFirestore _firestore;

  RouteRepositoryImpl(this._firestore);

  CollectionReference get _routes => _firestore.collection('routes');
  CollectionReference get _fleets => _firestore.collection('fleets');

  @override
  Stream<List<RouteModel>> routesStream() {
    return _routes
        .snapshots()
        .map((snapshot) => snapshot.docs.map(RouteModel.fromSnapshot).toList());
  }

  @override
  Future<RouteModel> addRoute(RouteModel route) async {
    final doc = await _routes.add(route.toDocument());

    return route.copyWith(
      id: doc.id,
      reference: doc,
    );
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
  Future<RouteModel> updateRoute(RouteModel route) async {
    await _routes.doc(route.id).update(route.toDocument());
    return route;
  }

  @override
  Future<void> assignRouteToFleets(
    String routeId,
    List<String> fleetIds, [
    List<String> deletedFleetIds = const [],
  ]) async {
    final batch = _firestore.batch();
    for (final fleetId in deletedFleetIds) {
      final ref = _fleets.doc(fleetId);
      batch.update(ref, {
        'route_id': null,
      });
    }

    for (final fleetId in fleetIds) {
      final ref = _fleets.doc(fleetId);
      batch.update(ref, {
        'route_id': routeId,
      });
    }

    await batch.commit();
  }

  @override
  Future<void> unassignRouteFromFleets(
    String routeId,
    List<String> fleetIds,
  ) async {
    final batch = _firestore.batch();
    for (final fleetId in fleetIds) {
      final ref = _fleets.doc(fleetId);
      batch.update(ref, {
        'route_id': null,
      });
    }
    await batch.commit();
  }
}
