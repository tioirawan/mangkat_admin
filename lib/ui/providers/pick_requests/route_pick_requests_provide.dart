import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/pick_request_model.dart';
import '../../../domain/repositories/pick_request_repository.dart';

final routePickRequestsProvider = StreamProvider.autoDispose
    .family<List<PickRequestModel>, String?>((ref, routeId) {
  if (routeId == null) {
    return Stream.value([]);
  }

  final repository = ref.watch(pickRequestRepositoryProvider);

  return repository.streamRoutePickRequests(routeId);
});
