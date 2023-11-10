import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/models/route_model.dart';
import '../../../domain/repositories/route_repository.dart';
import '../../providers/common/map_controller/map_provider.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/driver/driver_provider.dart';
import '../../providers/route/focused_route_provider.dart';
import '../../providers/route/route_detail_provider.dart';
import '../../providers/route/route_fleets_provider.dart';
import '../../providers/route/route_provider.dart';
import '../../themes/app_theme.dart';
import '../../widgets/driver_pill.dart';
import '../../widgets/fleet_focus_button.dart';
import '../../widgets/fleet_pill.dart';
import '../../widgets/fleet_selector_popup.dart';
import '../../widgets/route_pill.dart';

class RouteDetailWindow extends ConsumerStatefulWidget {
  static const String name = 'window/route-detail';

  final String? routeId;

  const RouteDetailWindow({
    super.key,
    required this.routeId,
  });

  @override
  ConsumerState<RouteDetailWindow> createState() => _FleetDetailWindowState();
}

class _FleetDetailWindowState extends ConsumerState<RouteDetailWindow> {
  @override
  Widget build(BuildContext context) {
    final route = ref.watch(routeProvider(widget.routeId));
    final detail = ref.watch(routeDetailProvider(widget.routeId));
    final fleets = ref.watch(routeFleetsProvider(widget.routeId));
    final focusedRoute = ref.watch(focusedRouteProvider);

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
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        route?.name ?? '-',
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
                ),
                Material(
                  shape: const CircleBorder(),
                  color: focusedRoute?.id == route?.id
                      ? Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.1)
                      : Theme.of(context).colorScheme.primary,
                  child: InkWell(
                    onTap: () {
                      if (route?.id != focusedRoute?.id) {
                        ref.read(focusedRouteProvider.notifier).state = route;
                        ref.read(mapControllerProvider.notifier).boundTo(
                            LatLngBounds.fromPoints(route!.checkpoints!));
                        ref
                            .read(rightSidebarContentController.notifier)
                            .open(RouteDetailWindow.name, route.id);
                      } else {
                        ref.read(focusedRouteProvider.notifier).state = null;
                      }
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        focusedRoute?.id == route?.id
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Theme.of(context).colorScheme.onError,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(RouteDetailWindow.name),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildDetail(context, route, detail),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildFleets(context, fleets, route),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildFleets(
      BuildContext context, List<FleetModel> fleets, RouteModel? route) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Armada',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Material(
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.primary,
              child: InkWell(
                onTap: () async {
                  final newFleets = await FleetSelectorPopup.show(
                    context,
                    selected: fleets.map((e) => e.id!).toList(),
                    forRouteId: route?.id,
                  );

                  final deletedFleets = fleets
                      .where((element) => !newFleets.contains(element.id))
                      .map((e) => e.id!)
                      .toList();

                  if (newFleets.isNotEmpty && route?.id != null) {
                    await ref.read(routeRepositoryProvider).assignRouteToFleets(
                          route!.id!,
                          newFleets,
                          deletedFleets,
                        );

                    setState(() {});
                  }
                },
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.create_rounded,
                    color: Theme.of(context).colorScheme.onError,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildFleetsList(fleets),
      ],
    );
  }

  Column _buildDetail(
    BuildContext context,
    RouteModel? route,
    RouteDetail? detail,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(route?.description ?? '-'),
        const SizedBox(height: 8),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text(
                  'Jarak',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    route?.distance != null
                        ? '${route!.distance.toStringAsFixed(2)} km'
                        : '-',
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Armada',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${detail?.totalFleets ?? '-'}",
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Driver',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${detail?.totalDriver ?? '-'}",
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Permintaan pick-up',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${detail?.totalPickupRequests ?? '-'}",
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Penumpang saat ini',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${detail?.totalPassengers ?? '-'}",
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Kapasitas',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        _buildRouteOccupancy(
          detail?.totalCapacity ?? 0,
          detail?.totalPassengers ?? 0,
        ),
      ],
    );
  }

  Widget _buildFleetsList(List<FleetModel> fleets) {
    final textTheme = Theme.of(context).textTheme;

    if (fleets.isEmpty) {
      return const Text('Belum ada armada yang ditugaskan untuk trayek ini');
    }

    // table vehicleNumber, Driver Name, Actions
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'No.',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Nama Driver',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        for (final fleet in fleets)
          TableRow(
            decoration: const BoxDecoration(
                // color: isFocused
                //     ? Theme.of(context).colorScheme.onBackground.withOpacity(0.1)
                //     : null,
                ),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FleetPill(fleet: fleet),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Consumer(builder: (context, ref, _) {
                  final driver = ref.watch(driverProvider(fleet.driverId));

                  return driver != null
                      ? DriverPill(driver: driver)
                      : const Text('-');
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FleetFocusButton(fleet: fleet),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildRouteOccupancy(int capacity, int occupancy) {
    final percentage = capacity == 0 ? 0 : occupancy / capacity * 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$occupancy dari $capacity (${percentage.toStringAsFixed(0)}%)',
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
            end: capacity > 0 ? occupancy / capacity : 0,
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
              '$capacity',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
