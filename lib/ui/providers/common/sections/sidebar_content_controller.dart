import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/driver_model.dart';
import '../../../../domain/models/fleet_model.dart';
import '../../../../domain/models/route_model.dart';
import '../../../../domain/models/switching_area_model.dart';
import '../../../windows/sidebars/add_driver_window.dart';
import '../../../windows/sidebars/add_fleet_window.dart';
import '../../../windows/sidebars/add_route_window.dart';
import '../../../windows/sidebars/add_switching_area_window.dart';
import '../../../windows/sidebars/filter_window.dart';
import '../../../windows/sidebars/fleet_detail_window.dart';
import '../../../windows/sidebars/load_balancer_window.dart';
import '../../../windows/sidebars/route_detail_window.dart';
import '../../../windows/sidebars/statistic_window.dart';
import '../../../windows/sidebars/switching_area_detail_window.dart';
import '../events/global_events.dart';
import '../events/global_events_provider.dart';

final leftSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (ref) => ContentWindowNotifier(
    ref.read(globalEventsProvider.notifier),
  )
    ..register(
      StatisticWindow.name,
      (_) => const FilterWindow(),
      true,
    )
    ..register(
      LoadBalancerWindow.name,
      (_) => const LoadBalancerWindow(),
      true,
    ),
);

final rightSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (ref) => ContentWindowNotifier(
    ref.read(globalEventsProvider.notifier),
  )
    ..register(
      StatisticWindow.name,
      (_) => const StatisticWindow(),
      false,
    )
    ..register(
      AddRouteWindow.name,
      (Object? arg) => AddRouteWindow(
        route: arg as RouteModel?,
      ),
      false,
    )
    ..register(
      AddFleetWindow.name,
      (Object? arg) => AddFleetWindow(
        fleet: arg as FleetModel?,
      ),
      false,
    )
    ..register(
      AddDriverWindow.name,
      (Object? arg) => AddDriverWindow(
        driver: arg as DriverModel?,
      ),
      false,
    )
    ..register(
      FleetDetailWindow.name,
      (Object? arg) => FleetDetailWindow(
        fleetId: arg as String?,
      ),
      false,
    )
    ..register(
      RouteDetailWindow.name,
      (Object? arg) => RouteDetailWindow(
        routeId: arg as String?,
      ),
      false,
    )
    ..register(
        AddSwitchingAreaWindow.name,
        (Object? arg) => AddSwitchingAreaWindow(
              switchingArea: arg as SwitchingAreaModel?,
            ),
        false)
    ..register(
      SwitchingAreaDetailWindow.name,
      (Object? arg) => SwitchingAreaDetailWindow(
        switchingAreaId: arg as String?,
      ),
      false,
    ),
);

class ContentWindowNotifier extends StateNotifier<Map<String, (bool, Widget)>> {
  final GlobalEventsNotifier _globalEventsNotifier;

  ContentWindowNotifier(
    this._globalEventsNotifier,
  ) : super({});

  // used as a way to pass argument to the window
  final Map<String, Widget Function(Object?)> builders = {};

  Widget build(String id, [Object? argument]) {
    return SizedBox(
      key: argument != null
          ? ValueKey('window_${id}_$argument')
          : ValueKey('window_$id'),
      child: builders[id]!(argument),
    );
  }

  // String: id, bool: visibility, Widget: window
  void register(
    String id,
    Widget Function(Object?) windowBuilder, [
    bool isOpen = false,
  ]) {
    builders[id] = windowBuilder;
    state = {
      ...state,
      id: (isOpen, build(id)),
    };
  }

  void toggle(String id, [Object? argument]) {
    if (!state.keys.contains(id)) {
      return;
    }

    final (isVisible, _) = state[id]!;
    final newWindow = build(id, argument);

    if (isVisible) {
      // close the window
      if (id == AddRouteWindow.name) {
        _globalEventsNotifier.add(GlobalEventAddRouteWindowWillClose());
      } else if (id == AddSwitchingAreaWindow.name) {
        _globalEventsNotifier.add(GlobalEventAddSwitchingAreaWindowWillClose());
      }

      state = {
        id: (false, newWindow),
        ...state..remove(id), // trick to put the last item to the top
      };
    } else {
      // open the window
      state = {
        id: (true, newWindow),
        ...state..remove(id),
      };
    }
  }

  void open(String id, [Object? argument]) {
    if (!state.keys.contains(id)) {
      return;
    }

    state = {
      id: (true, builders[id]!(null)),
      ...state..remove(id),
    };

    final newWindow = build(id, argument);

    state = {
      id: (true, newWindow),
      ...state..remove(id),
    };
  }

  void close(String id) {
    if (!state.keys.contains(id)) {
      return;
    }

    final (_, window) = state[id]!;

    if (id == AddRouteWindow.name) {
      _globalEventsNotifier.add(GlobalEventAddRouteWindowWillClose());
    } else if (id == AddSwitchingAreaWindow.name) {
      _globalEventsNotifier.add(GlobalEventAddSwitchingAreaWindowWillClose());
    }

    state = {
      ...state,
      id: (false, window),
    };
  }
}
