// route that is being edited
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';

final editedRouteProvider = StateProvider<RouteModel?>((ref) => null);
