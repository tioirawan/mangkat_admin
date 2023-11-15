import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/switching_area_model.dart';
import '../../../domain/repositories/switching_area_repository.dart';

final switchingAreaControllerProvider = Provider<SwitchingAreaController>(
    (ref) =>
        SwitchingAreaController(ref.watch(switchingAreaRepositoryProvider)));

class SwitchingAreaController {
  final SwitchingAreaRepository _repository;

  SwitchingAreaController(this._repository);

  Future<SwitchingAreaModel> add(SwitchingAreaModel switchingArea) async {
    return await _repository.addSwitchingArea(switchingArea);
  }

  Future<SwitchingAreaModel> update(SwitchingAreaModel switchingArea) async {
    return await _repository.update(switchingArea);
  }

  Future<void> delete(SwitchingAreaModel switchingArea) async {
    await _repository.deleteSwitchingArea(switchingArea);
  }
}
