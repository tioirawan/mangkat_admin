import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/route_repository_impl.dart';
import '../models/route_model.dart';
import '../services/firebase_service.dart';

abstract class RouteRepository {
  Stream<List<RouteModel>> routesStream();
  Future<List<RouteModel>> getRoutes();
  Future<RouteModel> getRoute(String id);
  Future<RouteModel> addRoute(RouteModel route);
  Future<RouteModel> updateRoute(RouteModel route);
  Future<void> deleteRoute(RouteModel route);
}

final routeRepositoryProvider = Provider<RouteRepository>(
  (ref) => RouteRepositoryImpl(ref.watch(firestoreProvider)),
);
