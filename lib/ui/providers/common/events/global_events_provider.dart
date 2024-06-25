import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global_events.dart';

final globalEventsProvider =
    StateNotifierProvider<GlobalEventsNotifier, GlobalEvent?>(
  (_) => GlobalEventsNotifier(),
);

/// Notifies about global events
/// For example, when a window is going to be closed, and we need to do some actions
/// before it happens, like clearing map markers
class GlobalEventsNotifier extends StateNotifier<GlobalEvent?> {
  GlobalEventsNotifier() : super(null);

  final List<GlobalEvent> _events = [];

  void add(GlobalEvent event) {
    _events.add(event);
    state = event;
  }
}
