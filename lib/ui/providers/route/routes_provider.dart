import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import '../../../domain/repositories/route_repository.dart';

final routesProvider = StreamProvider<List<RouteModel>>(
  (ref) => ref.watch(routeRepositoryProvider).routesStream(),
);
