import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/pick_request_repository_impl.dart';
import '../models/pick_request_model.dart';
import '../services/firebase_service.dart';

abstract class PickRequestRepository {
  Stream<List<PickRequestModel>> streamRoutePickRequests(String routeId);
  Stream<List<PickRequestModel>> streamAllPickRequests();
}

final pickRequestRepositoryProvider = Provider<PickRequestRepository>(
  (ref) => PickRequestRepositoryImpl(ref.watch(firestoreProvider)),
);
