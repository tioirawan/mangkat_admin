import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/route/route_detail_provider.dart';
import '../../providers/route/route_provider.dart';
import '../../providers/switching_area/switching_area_available_fleets_by_route_provider.dart';
import '../../providers/switching_area/switching_area_provider.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class SwitchingAreaDetailWindow extends ConsumerStatefulWidget {
  static const String name = 'window/switch-area-detail';

  final String? switchingAreaId;

  const SwitchingAreaDetailWindow({
    super.key,
    required this.switchingAreaId,
  });

  @override
  ConsumerState<SwitchingAreaDetailWindow> createState() =>
      _SwitchingAreaDetailWindowState();
}

class _SwitchingAreaDetailWindowState
    extends ConsumerState<SwitchingAreaDetailWindow> {
  @override
  Widget build(BuildContext context) {
    final switchingArea =
        ref.watch(switchingAreaProvider(widget.switchingAreaId));

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
                        switchingArea?.name ?? '-',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(SwitchingAreaDetailWindow.name),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Trayek',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                for (final routeId in switchingArea?.routes ?? [])
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: RouteOccupancyBar(
                      routeId: routeId,
                      switchingAreaId: widget.switchingAreaId,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RouteOccupancyBar extends ConsumerWidget {
  final String routeId;
  final String? switchingAreaId;

  const RouteOccupancyBar({
    super.key,
    required this.routeId,
    this.switchingAreaId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider(routeId));
    final routeDetail = ref.watch(routeDetailProvider(routeId));
    final freeSwitchFleets = ref.watch(
      switchingAreaAvailableFleetsByRouteProvider(routeId),
    );

    if (route == null) {
      return const SizedBox();
    }

    int freeSwitchCapacityCount = 0;

    if (route.name == 'HL') {
      print('HL');
    }

    if (switchingAreaId == null) {
      // count total free switch fleets capacity for all switching area
      freeSwitchCapacityCount = freeSwitchFleets.values
          .map<int>(
            (List<FleetModel> e) => e.fold<int>(
              0,
              (previousValue, element) =>
                  previousValue + (element.maxCapacity ?? 0),
            ),
          )
          .reduce((value, element) => value + element);
    } else {
      // count total free switch fleets capacity only for this switching area
      freeSwitchCapacityCount = freeSwitchFleets[switchingAreaId]?.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.maxCapacity ?? 0),
          ) ??
          0;
    }

    print(freeSwitchCapacityCount);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: RoutePill(route: route),
              ),
            ),
            Expanded(
              child: _buildRouteOccupancy(
                context,
                routeDetail?.totalCapacity ?? 0,
                freeSwitchCapacityCount,
                routeDetail?.totalPassengers ?? 0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRouteOccupancy(
    BuildContext context,
    int capacity,
    int freeSwitchFleets,
    int occupancy,
  ) {
    final occupancyPercentage = capacity == 0 ? 0 : occupancy / capacity;
    final freeSwitchFleetsPercentage =
        capacity == 0 ? 0 : freeSwitchFleets / capacity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Kapasitas: $capacity, Terisi: $occupancy (${(occupancyPercentage * 100).toStringAsFixed(0)}%), Tersedia: $freeSwitchFleets',
        //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //         fontWeight: FontWeight.w700,
        //         color: Theme.of(context).colorScheme.primary,
        //       ),
        // ),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  children: [
                    const TextSpan(
                      text: 'Terisi: ',
                    ),
                    TextSpan(
                      text:
                          '$occupancy (${(occupancyPercentage * 100).toStringAsFixed(0)}%)',
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    const TextSpan(
                      text: ', Tersedia: ',
                    ),
                    TextSpan(
                      text:
                          '$freeSwitchFleets (${(freeSwitchFleetsPercentage * 100).toStringAsFixed(0)}%)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '/$capacity',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Row(
                children: [
                  TweenAnimationBuilder(
                      duration: 1.seconds,
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 0,
                        end: occupancyPercentage.toDouble(),
                      ),
                      builder: (context, value, _) {
                        const safeOccupancyTreshold = 0.8;

                        const Color safeOccupancy = Colors.green;
                        const Color dangerOccupancy = Colors.red;

                        return Container(
                          width: constraints.maxWidth * value.clamp(0, 1),
                          height: 12,
                          decoration: BoxDecoration(
                            color: value < safeOccupancyTreshold
                                ? safeOccupancy
                                : Color.lerp(
                                    safeOccupancy,
                                    dangerOccupancy,
                                    (value - safeOccupancyTreshold) /
                                        (1 - safeOccupancyTreshold),
                                  )!,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        );
                      }),
                  TweenAnimationBuilder(
                    duration: 1.seconds,
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: freeSwitchFleetsPercentage.toDouble(),
                    ),
                    builder: (context, value, _) {
                      return Container(
                        width: constraints.maxWidth * value.clamp(0, 1),
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
