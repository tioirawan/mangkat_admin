import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/repositories/route_repository.dart';
import '../../providers/common/map_controller/map_provider.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/driver/driver_provider.dart';
import '../../providers/route/focused_route_provider.dart';
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              .where(
                                  (element) => !newFleets.contains(element.id))
                              .map((e) => e.id!)
                              .toList();

                          if (newFleets.isNotEmpty && route?.id != null) {
                            await ref
                                .read(routeRepositoryProvider)
                                .assignRouteToFleets(
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
            ),
          ),
        ],
      ),
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
}
