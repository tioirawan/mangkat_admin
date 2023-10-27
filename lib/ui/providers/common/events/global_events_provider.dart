import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global_events.dart';

final globalEventsProvider =
    StateNotifierProvider<GlobalEventsNotifier, GlobalEvent?>(
  (_) => GlobalEventsNotifier(),
);

class GlobalEventsNotifier extends StateNotifier<GlobalEvent?> {
  GlobalEventsNotifier() : super(null);

  final List<GlobalEvent> _events = [];

  void add(GlobalEvent event) {
    _events.add(event);
    state = event;
  }
}
