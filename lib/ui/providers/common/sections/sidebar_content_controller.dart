import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/driver_model.dart';
import '../../../../domain/models/fleet_model.dart';
import '../../../windows/sidebars/add_driver_window.dart';
import '../../../windows/sidebars/add_fleet_window.dart';
import '../../../windows/sidebars/add_route_window.dart';
import '../../../windows/sidebars/statistic_window.dart';

final leftSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (_) => ContentWindowNotifier()
    ..register(
      StatisticWindow.name,
      (_) => const StatisticWindow(),
      false,
    ),
);

final rightSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (_) => ContentWindowNotifier()
    ..register(
      StatisticWindow.name,
      (_) => const StatisticWindow(),
      false,
    )
    ..register(
      AddRouteWindow.name,
      (Object? arg) => const AddRouteWindow(),
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
    ),
);

class ContentWindowNotifier extends StateNotifier<Map<String, (bool, Widget)>> {
  ContentWindowNotifier() : super({});

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
      state = {
        id: (false, newWindow),
        ...state..remove(id), // trick to put the last item to the top
      };
    } else {
      if (argument != null) {}

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

    state = {
      ...state,
      id: (false, window),
    };
  }
}
