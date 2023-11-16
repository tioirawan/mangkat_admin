import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/models/route_model.dart';
import '../../../domain/repositories/route_repository.dart';
import '../switching_area/switching_area_free_fleets_provider.dart';
import 'load_balancer_logs_provider.dart';
import 'load_balancer_provider.dart';
import 'load_balancer_state.dart';

final isLoadBalancerActiveProvider =
    StateProvider.family<bool, String?>((ref, switchingAreaId) => false);

final loadBalancerServiceProvider =
    Provider.family<LoadBalancerService?, String?>((ref, switchAreaId) {
  if (switchAreaId == null) {
    return null;
  }

  return LoadBalancerService(ref, switchAreaId);
});

class LoadBalancerService {
  final Ref _ref;
  final String switchingAreaId;

  LoadBalancerService(this._ref, this.switchingAreaId);

  LoadBalancerLogsNotifier get logger =>
      _ref.read(loadBalancerLogsProvider(switchingAreaId).notifier);

  Timer? _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), balance);
    logger.add('Load balancer diaktifkan');
  }

  Future<void> balance(Timer timer) async {
    final LoadBalancerState data = _ref.read(
      loadBalancerDetailProvider(switchingAreaId),
    );

    if (data.routeWithMaxLoad == null ||
        data.routeWithMinLoad == null ||
        data.imbalance < data.convergenceThreshold) {
      logger.add('Beban trayek stabil');
      return;
    }

    logger.add('Beban trayek tidak stabil');

    await Future.delayed(const Duration(seconds: 1));

    // this only returns free fleets from other route
    // final freeFleets = data.routesDetails.values
    //     .map((value) => value.freeFleets[switchingAreaId] ?? [])
    //     .expand((element) => element)
    //     .toList();

    // we need to add fleets in this swithcing area without route
    final freeFleets =
        _ref.read(switchingAreaFreeFleetsProvider(switchingAreaId));

    final capacityToMove = data.imbalance *
        data.routesDetails[data.routeWithMaxLoad!]!.totalCapacity;
    // data.adjustmentFactor;

    final routesCandidates = data.routesDetails.entries
        .where(
          (element) => element.key.id != data.routeWithMaxLoad!.id,
        )
        .toList();

    routesCandidates.sort((a, b) {
      // lower load first
      return a.value.load.compareTo(b.value.load);
    });

    List<FleetModel> fleetsToMove = [];

    // first, find fleets without route with this trick
    for (final routeCandidate in [null, ...routesCandidates]) {
      final fleets = freeFleets.where((fleet) {
        return fleet.routeId == routeCandidate?.key.id;
      }).toList();

      fleets.sort((a, b) {
        // lower capacity first
        return a.maxCapacity!.compareTo(b.maxCapacity!);
      });

      // according to capacity to move, find best fleets to move
      int capacityMoved = 0;

      for (final fleet in fleets) {
        fleetsToMove.add(fleet);
        capacityMoved += fleet.maxCapacity!;

        if (capacityMoved >= capacityToMove) {
          break;
        }
      }

      if (capacityMoved >= capacityToMove) {
        break;
      }
    }

    if (fleetsToMove.isEmpty) {
      logger.add('Tidak ada armada yang dapat dipindahkan');
      return;
    }

    logger.add(
      'Memindahkan ${fleetsToMove.length} armada ke ${data.routeWithMaxLoad?.name}',
    );

    await _assignFleetsToRoute(fleetsToMove, data.routeWithMaxLoad!);

    // logger.add('$timer Load balancer balancing for $switchingAreaId');
  }

  Future<void> _assignFleetsToRoute(
      List<FleetModel> fleets, RouteModel route) async {
    await _ref.read(routeRepositoryProvider).assignRouteToFleets(
          route.id!,
          fleets.map((e) => e.id!).toList(),
        );
  }

  void stop() {
    _timer?.cancel();
    logger.add('Load balancer dimatikan');
  }
}
