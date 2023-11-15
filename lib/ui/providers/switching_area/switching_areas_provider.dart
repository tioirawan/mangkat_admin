import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/switching_area_model.dart';
import '../../../domain/repositories/switching_area_repository.dart';

final switchingAreasProvider =
    StreamProvider.autoDispose<List<SwitchingAreaModel>>(
  (ref) => ref.watch(switchingAreaRepositoryProvider).streamSwitchingAreas(),
);
