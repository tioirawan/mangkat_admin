import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadBalancerLogsProvider = StateNotifierProvider.family<
    LoadBalancerLogsNotifier,
    List<(DateTime, String)>,
    String?>((ref, switchingAreaId) {
  return LoadBalancerLogsNotifier();
});

class LoadBalancerLogsNotifier extends StateNotifier<List<(DateTime, String)>> {
  LoadBalancerLogsNotifier() : super([]);

  void add(String log) {
    state = [...state, (DateTime.now(), log)];
  }
}
