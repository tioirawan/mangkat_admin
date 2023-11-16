import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';
import '../route/route_detail_provider.dart';
import '../route/route_provider.dart';
import '../switching_area/switching_area_provider.dart';
import 'load_balancer_state.dart';

final loadBalancerDetailProvider = Provider.autoDispose
    .family<LoadBalancerState, String?>((ref, switchingAreaId) {
  final switchingArea = ref.watch(switchingAreaProvider(switchingAreaId));

  if (switchingArea == null) {
    return LoadBalancerState.initial();
  }

  List<RouteModel> routes = [];

  for (final routeId in switchingArea.routes ?? []) {
    final route = ref.watch(routeProvider(routeId));
    // final freeSwitchFleets = ref.watch(
    //   routeFreeFleetsProvider(routeId),
    // );

    if (route != null) {
      routes.add(route);
    }
  }

  final Map<RouteModel, RouteDetail> routesDetails = {};

  RouteModel? routeWithMaxLoad;
  double? maxLoad;

  RouteModel? routeWithMinLoad;
  double? minLoad;

  for (final route in routes) {
    routesDetails[route] = ref.watch(routeDetailProvider(route.id))!;

    final routeDetail = routesDetails[route]!;

    if (maxLoad == null || routeDetail.load > maxLoad) {
      maxLoad = routeDetail.load;
      routeWithMaxLoad = route;
    }

    if (minLoad == null || routeDetail.load < minLoad) {
      minLoad = routeDetail.load;
      routeWithMinLoad = route;
    }
  }

  double imbalance = (maxLoad ?? 0) - (minLoad ?? 0);

  return LoadBalancerState(
    routesDetails: routesDetails,
    routeWithMaxLoad: routeWithMaxLoad,
    routeWithMinLoad: routeWithMinLoad,
    imbalance: imbalance,
  );
});

/// LoadBalancerController
///
/// This class is used to balance the fleets routes assigment.
/// Let's say route A has 90% load and route B has 10% load.
/// The controller will assign some of route B fleets (with some conditions)
/// to route A, so the load will be balanced.
// class LoadBalancerNotifier extends StateNotifier<LoadBalancerState> {
  
// }
