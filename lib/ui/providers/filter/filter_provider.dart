import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import '../route/routes_provider.dart';

final routeFilterProvider =
    StateNotifierProvider<RouteFilterNotifier, List<String>>(
        (ref) => RouteFilterNotifier(ref));

class RouteFilterNotifier extends StateNotifier<List<String>> {
  final Ref ref;

  late ProviderSubscription _subscription;

  RouteFilterNotifier(this.ref) : super([]) {
    _subscription = ref.listen<AsyncValue<List<RouteModel>>>(routesProvider,
        (prev, routes) {
      final prevRoutes = prev?.asData?.value ?? [];
      final currentRoutes = routes.asData?.value ?? [];

      if (state.isEmpty) {
        state = currentRoutes.map((e) => e.id!).toList();
      }

      // check for new routes
      if (currentRoutes.length > prevRoutes.length) {
        final newRoutes = currentRoutes
            .where((element) => !prevRoutes.contains(element))
            .toList();
        final newRouteIds = newRoutes.map((e) => e.id!).toList();
        state = [...state, ...newRouteIds];
      }

      // check for deleted routes
      if (currentRoutes.length < prevRoutes.length) {
        final deletedRoutes = prevRoutes
            .where((element) => !currentRoutes.contains(element))
            .toList();
        final deletedRouteIds = deletedRoutes.map((e) => e.id!).toList();
        state = state
            .where((element) => !deletedRouteIds.contains(element))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }

  void selectAll(List<String> ids) {
    state = ids;
  }

  void add(String id) {
    state = [...state, id];
  }

  void remove(String id) {
    state = state.where((element) => element != id).toList();
  }
}
