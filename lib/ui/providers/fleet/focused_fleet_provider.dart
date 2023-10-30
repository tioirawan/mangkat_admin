// route that is being edited
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';

final focusedFleetProvider = StateProvider<FleetModel?>((ref) => null);
