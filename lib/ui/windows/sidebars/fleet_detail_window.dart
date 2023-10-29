import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/driver_model.dart';
import '../../../domain/models/fleet_position_model.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/driver/driver_provider.dart';
import '../../providers/fleet/fleet_occupancy_provider.dart';
import '../../providers/fleet/fleet_position_provider.dart';
import '../../providers/fleet/fleet_provider.dart';
import '../../providers/route/route_provider.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class FleetDetailWindow extends ConsumerStatefulWidget {
  static const String name = 'window/fleet-detail';

  final String? fleetId;

  const FleetDetailWindow({
    super.key,
    required this.fleetId,
  });

  @override
  ConsumerState<FleetDetailWindow> createState() => _FleetDetailWindowState();
}

class _FleetDetailWindowState extends ConsumerState<FleetDetailWindow> {
  @override
  Widget build(BuildContext context) {
    final fleet = ref.watch(fleetProvider(widget.fleetId));
    final fleetPosition = ref.watch(fleetPositionProvider(widget.fleetId));
    final fleetOccupancy = ref.watch(fleetOccupancyProvider(widget.fleetId));

    final route = ref.watch(routeProvider(fleet?.routeId));
    final driver = ref.watch(driverProvider(fleet?.driverId));

    return Container(
      decoration: AppTheme.windowCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      fleet?.vehicleNumber ?? '-',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    if (route != null) ...[
                      const SizedBox(width: 16),
                      RoutePill(route: route),
                    ],
                  ],
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(FleetDetailWindow.name),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close_rounded,
                        color: Theme.of(context).colorScheme.onError,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengemudi',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildDriverDetail(driver),
                const SizedBox(height: 16 * 2),
                Text(
                  'Kecepatan',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildSpeed(fleetPosition),
                const SizedBox(height: 16),
                Text(
                  'Okupansi',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildFleetOccupancy(
                  fleet?.maxCapacity ?? 0,
                  fleetOccupancy.asData?.value ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeed(FleetPositionModel? fleetPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${fleetPosition?.speed ?? '-'} km/h',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder(
          duration: 1.seconds,
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: fleetPosition?.speed != null ? fleetPosition!.speed! / 100 : 0,
          ),
          builder: (context, value, _) {
            const safeSpeedTreshold = 0.45;

            const Color safeSpeed = Colors.green;
            const Color dangerSpeed = Colors.red;

            return LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                value < safeSpeedTreshold
                    ? safeSpeed
                    : Color.lerp(
                        safeSpeed,
                        dangerSpeed,
                        (value - safeSpeedTreshold) / (1 - safeSpeedTreshold),
                      )!,
              ),
              minHeight: 12,
              borderRadius: BorderRadius.circular(999),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              '100',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        )
      ],
    );
  }

  // just like speed
  Widget _buildFleetOccupancy(int maxCapacity, int fleetOccupancy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fleetOccupancy dari $maxCapacity',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder(
          duration: 1.seconds,
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: maxCapacity > 0 ? fleetOccupancy / maxCapacity : 0,
          ),
          builder: (context, value, _) {
            const safeOccupancyTreshold = 0.8;

            const Color safeOccupancy = Colors.green;
            const Color dangerOccupancy = Colors.red;

            return LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                value < safeOccupancyTreshold
                    ? safeOccupancy
                    : Color.lerp(
                        safeOccupancy,
                        dangerOccupancy,
                        (value - safeOccupancyTreshold) /
                            (1 - safeOccupancyTreshold),
                      )!,
              ),
              minHeight: 12,
              borderRadius: BorderRadius.circular(999),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              '$maxCapacity',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        )
      ],
    );
  }

  Row _buildDriverDetail(DriverModel? driver) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: driver?.image != null
              ? CachedNetworkImageProvider(driver!.image!)
              : null,
          child: driver?.image == null ? const Icon(Icons.person) : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driver?.name ?? '-',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                driver?.phone ?? '-',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
