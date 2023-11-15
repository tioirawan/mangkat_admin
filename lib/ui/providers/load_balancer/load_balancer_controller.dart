import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import '../fleet/fleets_occupancies_provider.dart';
import '../route/route_detail_provider.dart';
import '../route/routes_provider.dart';

final isLoadBalancerActiveProvider = StateProvider<bool>((ref) {
  return false;
});

final loadBalancerProvider = StateNotifierProvider.autoDispose<
    LoadBalancerNotifier, Map<RouteModel, RouteDetail>>((ref) {
  // watching fleetsOccupanciesProvider here to make sure it's always alive
  ref.watch(fleetsOccupanciesProvider);

  final routes = ref.watch(routesProvider).value ?? [];

  return LoadBalancerNotifier(routes, ref);
});

/// LoadBalancerController
///
/// This class is used to balance the fleets routes assigment.
/// Let's say route A has 90% load and route B has 10% load.
/// The controller will assign some of route B fleets (with some conditions)
/// to route A, so the load will be balanced.
class LoadBalancerNotifier extends StateNotifier<Map<RouteModel, RouteDetail>> {
  final List<RouteModel> _routes;
  final Ref _ref;

  bool get isBalancing => _ref.read(isLoadBalancerActiveProvider);

  // calculate fleets candidates
  // candidates fleets are fleets that is currently in "switching-point", has 0 passengers, and has driver

  LoadBalancerNotifier(this._routes, this._ref) : super({}) {
    updateRouteDetails();
  }

  /// This is a pretty expensive operation, so we should minimize the usage
  void updateRouteDetails() {
    final Map<RouteModel, RouteDetail> routesDetails = {};

    for (final route in _routes) {
      routesDetails[route] = _ref.read(routeDetailProvider(route.id))!;
    }

    state = routesDetails;
  }
}
