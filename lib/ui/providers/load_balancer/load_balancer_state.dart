import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/route_model.dart';
import '../route/route_detail_provider.dart';

part 'load_balancer_state.freezed.dart';

@freezed
class LoadBalancerState with _$LoadBalancerState {
  factory LoadBalancerState({
    required final Map<RouteModel, RouteDetail> routesDetails,
    @Default(10) final int maxIteration,
    @Default(0.5) final double convergenceThreshold,
    @Default(0.1) final double adjustmentFactor,
    RouteModel? routeWithMaxLoad,
    RouteModel? routeWithMinLoad,
    @Default(0) final double imbalance,
  }) = _LoadBalancerState;

  factory LoadBalancerState.initial() => LoadBalancerState(
        routesDetails: {},
      );
}
