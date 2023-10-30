import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/map_helper.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/map_controller/map_bound_provider.dart';
import '../providers/common/map_controller/map_provider.dart';
import '../providers/fleet/focused_fleet_provider.dart';
import '../providers/route/focused_route_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/fleet_pill.dart';
import '../widgets/route_pill.dart';

// some tools to control the view
class ControlBar extends ConsumerStatefulWidget {
  const ControlBar({super.key});

  @override
  ConsumerState<ControlBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<ControlBar> {
  @override
  Widget build(BuildContext context) {
    final focusedRoute = ref.watch(focusedRouteProvider);
    final focusedFleet = ref.watch(focusedFleetProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: AppTheme.windowCardDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
            padding: EdgeInsets.zero,
            onPressed: () {
              ref.read(mapControllerProvider.notifier).animateCamera(
                    CameraUpdate.newLatLngBounds(
                      ref.read(mapBoundProvider),
                      200,
                    ),
                  );
            },
            icon: const Icon(Icons.fullscreen_rounded),
          ),
          // display currently focused route
          if (focusedRoute?.id != null) ...[
            const SizedBox(width: 8),
            RoutePill(
              route: focusedRoute!,
              onTap: () {
                ref.read(mapControllerProvider.notifier).animateCamera(
                      CameraUpdate.newLatLngBounds(
                        MapHelper.computeBounds(focusedRoute.checkpoints!)!,
                        200,
                      ),
                    );
              },
              onClose: () {
                ref.read(focusedRouteProvider.notifier).state = null;
                ref.read(contentWindowProvider.notifier).close();
              },
            ),
          ],
          // display currently focused fleet
          if (focusedFleet?.id != null) ...[
            const SizedBox(width: 12),
            SizedBox(
              width: 120,
              // height: 38,
              child: FleetPill(
                fleet: focusedFleet!,
                onClose: () {
                  ref.read(focusedFleetProvider.notifier).state = null;
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
