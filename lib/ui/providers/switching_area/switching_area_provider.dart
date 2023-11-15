import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/switching_area_model.dart';
import 'switching_areas_provider.dart';

final switchingAreaProvider = Provider.autoDispose
    .family<SwitchingAreaModel?, String?>((ref, switchingAreaId) {
  if (switchingAreaId == null) {
    return null;
  }

  final List<SwitchingAreaModel> switchingAareas =
      ref.watch(switchingAreasProvider).value ?? [];

  return switchingAareas
      .where((switchingArea) => switchingArea.id == switchingAreaId)
      .firstOrNull;
});
