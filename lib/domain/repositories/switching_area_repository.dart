import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/switching_area_repository_impl.dart';
import '../models/switching_area_model.dart';
import '../services/firebase_service.dart';

abstract class SwitchingAreaRepository {
  Stream<List<SwitchingAreaModel>> streamSwitchingAreas();
  Stream<SwitchingAreaModel> streamSwitchingArea(String id);
  Future<List<SwitchingAreaModel>> getSwitchingAreas();
  Future<SwitchingAreaModel> getSwitchingArea(String id);
  Future<SwitchingAreaModel> addSwitchingArea(SwitchingAreaModel switchingArea);
  Future<SwitchingAreaModel> update(SwitchingAreaModel switchingArea);
  Future<void> deleteSwitchingArea(SwitchingAreaModel switchingArea);
}

final switchingAreaRepositoryProvider = Provider<SwitchingAreaRepository>(
  (ref) => SwitchingAreaRepositoryImpl(ref.watch(firestoreProvider)),
);
