import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/pick_request_model.dart';
import '../../../domain/repositories/pick_request_repository.dart';

final pickRequestsProvider =
    StreamProvider.autoDispose<List<PickRequestModel>>((ref) {
  final repository = ref.watch(pickRequestRepositoryProvider);

  return repository.streamAllPickRequests();
});
