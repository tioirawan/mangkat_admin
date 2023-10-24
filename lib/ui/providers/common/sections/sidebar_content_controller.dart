import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../windows/sidebars/add_route_window.dart';
import '../../../windows/sidebars/statistic_window.dart';

final leftSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (_) => ContentWindowNotifier()
    ..register(
      StatisticWindow.name,
      const StatisticWindow(),
      false,
    ),
);

final rightSidebarContentController =
    StateNotifierProvider<ContentWindowNotifier, Map<String, (bool, Widget)>>(
  (_) => ContentWindowNotifier()
    ..register(
      StatisticWindow.name,
      const StatisticWindow(),
      false,
    )
    ..register(
      AddRouteWindow.name,
      const AddRouteWindow(),
      false,
    ),
);

class ContentWindowNotifier extends StateNotifier<Map<String, (bool, Widget)>> {
  ContentWindowNotifier() : super({});

  // String: id, bool: visibility, Widget: window
  void register(String id, Widget window, [bool isOpen = false]) {
    state = {
      ...state,
      id: (isOpen, window),
    };
  }

  void toggle(String id) {
    if (!state.keys.contains(id)) {
      return;
    }

    final (isVisible, window) = state[id]!;

    if (isVisible) {
      state = {
        ...state,
        id: (false, window),
      };
    } else {
      state = {
        ...state,
        id: (true, window),
      };
    }
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
