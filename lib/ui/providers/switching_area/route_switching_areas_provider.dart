import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/switching_area_model.dart';
import 'switching_areas_provider.dart';

final routeSwitchingAreasProvider = Provider.autoDispose
    .family<List<SwitchingAreaModel>, String?>((ref, routeId) {
  if (routeId == null) {
    return [];
  }

  final switchingAreas = ref.watch(switchingAreasProvider).value ?? [];

  return switchingAreas
      .where((switchingArea) => switchingArea.routes?.contains(routeId) == true)
      .toList();
});
