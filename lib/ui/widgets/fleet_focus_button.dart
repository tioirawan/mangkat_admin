import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/models/fleet_model.dart';
import '../providers/common/map_controller/map_provider.dart';
import '../providers/fleet/fleet_position_provider.dart';
import '../providers/fleet/focused_fleet_provider.dart';

class FleetFocusButton extends ConsumerWidget {
  const FleetFocusButton({
    super.key,
    required this.fleet,
  });

  final FleetModel? fleet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedFleet = ref.watch(focusedFleetProvider);

    return Material(
      shape: const CircleBorder(),
      color: focusedFleet?.id == fleet?.id
          ? Theme.of(context).colorScheme.onBackground.withOpacity(0.1)
          : Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: () {
          if (focusedFleet?.id == fleet?.id) {
            ref.read(focusedFleetProvider.notifier).state = null;
            return;
          }

          final position = ref.watch(fleetPositionProvider(fleet?.id));

          ref.read(focusedFleetProvider.notifier).state = fleet;

          if (position != null) {
            ref.read(mapControllerProvider.notifier).animateTo(
                  LatLng(
                    position.latitude ?? 0,
                    position.longitude ?? 0,
                  ),
                  zoom: 16,
                );
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Posisi armada tidak diketahui'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            focusedFleet?.id == fleet?.id
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: Theme.of(context).colorScheme.onError,
            size: 18,
          ),
        ),
      ),
    );
  }
}
