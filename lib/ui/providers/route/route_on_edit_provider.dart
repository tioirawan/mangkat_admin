// route that is being edited
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/route_model.dart';

final routeOnEditProvider = StateProvider<RouteModel?>((ref) => null);
