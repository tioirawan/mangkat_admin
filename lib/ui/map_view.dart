import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../common/config_provider.dart';
import '../domain/models/fleet_position_model.dart';
import '../domain/models/route_model.dart';
import 'providers/common/map_controller/map_provider.dart';
import 'providers/common/sections/sidebar_content_controller.dart';
import 'providers/fleet/fleet_occupancy_provider.dart';
import 'providers/fleet/fleets_position_provider.dart';
import 'providers/fleet/fleets_provider.dart';
import 'providers/fleet/focused_fleet_provider.dart';
import 'providers/pick_requests/pick_requests_provider.dart';
import 'providers/route/edited_route_provider.dart';
import 'providers/route/focused_route_provider.dart';
import 'providers/route/routes_filtered_provider.dart';
import 'windows/sidebars/fleet_detail_window.dart';
import 'windows/sidebars/route_detail_window.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView>
    with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(mapControllerProvider.notifier)
          .setAnimatedMapController(_animatedMapController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(configProvider);
    final state = ref.watch(mapControllerProvider);
    final routes = ref.watch(routeFilteredProvider);
    final allRoutes = ref.watch(routeFilteredProvider);
    final fleetsPosition = ref.watch(fleetsPositionProvider);
    final focusedRoute = ref.watch(focusedRouteProvider);
    final focusedFleet = ref.watch(focusedFleetProvider);
    final editedRoute = ref.watch(editedRouteProvider);
    final fleets = ref.watch(fleetsProvider).value ?? [];
    final pickRequests = ref.watch(pickRequestsProvider).value ?? [];

    ref.listen(fleetsPositionProvider, (_, state) {
      final positions = state.value ?? {};

      if (focusedFleet == null) return;

      FleetPositionModel? position;

      for (final fleetId in positions.keys) {
        if (fleetId == focusedFleet.id) {
          position = positions[fleetId];
          break;
        }
      }

      if (position == null) return;

      ref.read(mapControllerProvider.notifier).animateTo(
            LatLng(
              position.latitude ?? 0,
              position.longitude ?? 0,
            ),
          );
    });

    return AnimatedContainer(
      duration: 200.milliseconds,
      curve: Curves.easeInOut,
      color: Theme.of(context).colorScheme.primary,
      padding: state.cleanMode ? const EdgeInsets.all(16) : EdgeInsets.zero,
      child: FlutterMap(
        options: MapOptions(
          center: const LatLng(-7.9726366, 112.6381682),
          zoom: 12,
          onTap: (_, LatLng latLng) {
            ref.read(mapControllerProvider.notifier).onTap(latLng);
          },
        ),
        mapController: _animatedMapController.mapController,
        children: [
          TileLayer(
            urlTemplate:
                'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=${config.mapTilerKey}',
            userAgentPackageName: 'id.mangkat.mangkat-admin',
          ),
          PolylineLayer(
            polylines: [
              for (final polyline in state.polylines.values) polyline,
            ],
          ),
          TappablePolylineLayer(
            polylines: [
              for (final route in routes)
                if (!state.cleanMode &&
                    route.id != null &&
                    route.routes != null &&
                    route.color != null &&
                    editedRoute?.id != route.id)
                  TaggedPolyline(
                    tag: route.id,
                    points: route.routes ?? [],
                    color: focusedRoute == null ||
                            focusedRoute.id == route.id ||
                            editedRoute == null
                        ? route.color!
                        : route.color!.withOpacity(0.25),
                    strokeWidth:
                        focusedRoute == null || focusedRoute.id == route.id
                            ? 3
                            : 1,
                    isDotted: route.type == RouteType.temporary,
                  ),
            ],
            onTap: (polylines, _) {
              if (polylines.isEmpty) return;
              final tag = polylines.first.tag;
              final route = allRoutes
                  .where(
                    (route) => route.id == tag,
                  )
                  .firstOrNull;

              if (route == null) return;

              ref.read(focusedRouteProvider.notifier).state = route;
              // ref
              //     .read(contentWindowProvider.notifier)
              //     .show(ContentWindowType.routeManager);
              ref
                  .read(rightSidebarContentController.notifier)
                  .open(RouteDetailWindow.name, route.id);
            },
          ),
          MarkerLayer(
            markers: [
              for (final marker in state.markers.values) marker,
              // render pick requests
              if (!state.cleanMode)
                for (final request in pickRequests)
                  if (routes.any((route) => route.id == request.routeId))
                    Marker(
                      point: LatLng(
                        request.latitude ?? 0,
                        request.longitude ?? 0,
                      ),
                      width: 8,
                      height: 8,
                      builder: (context) {
                        final route = allRoutes
                            .where(
                              (route) => route.id == request.routeId,
                            )
                            .firstOrNull;

                        return Container(
                          decoration: BoxDecoration(
                            color: (route?.color ?? Colors.blue),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red.withOpacity(0.25),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),

              // render fleet marker
              if (!state.cleanMode)
                for (MapEntry<String, FleetPositionModel> entry
                    in fleetsPosition.asData?.value.entries ?? [])
                  Marker(
                    point: LatLng(
                      entry.value.latitude ?? 0,
                      entry.value.longitude ?? 0,
                    ),
                    width: 22,
                    height: 22,
                    builder: (context) {
                      if (fleets.isEmpty || allRoutes.isEmpty) {
                        return const SizedBox();
                      }

                      final fleet = fleets
                          .where((fleet) => fleet.id == entry.key)
                          .firstOrNull;

                      final route = allRoutes
                          .where((route) => route.id == fleet?.routeId)
                          .firstOrNull;

                      if (fleet == null ||
                          route == null ||
                          !routes.any((element) => element.id == route.id)) {
                        return const SizedBox();
                      }

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(rightSidebarContentController.notifier)
                              .open(FleetDetailWindow.name, entry.key);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // indicating heading
                            Positioned(
                              top: -8,
                              left: -8,
                              right: -8,
                              bottom: -8,
                              child: Transform.rotate(
                                angle:
                                    (entry.value.heading ?? 0) * (3.14 / 180),
                                child: Transform.translate(
                                  offset: const Offset(
                                    0,
                                    -4,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: const BorderSide(
                                            width: 2,
                                            color: Colors.transparent,
                                          ),
                                          right: const BorderSide(
                                            width: 2,
                                            color: Colors.transparent,
                                          ),
                                          top: BorderSide(
                                            width: 8,
                                            color:
                                                Colors.white.withOpacity(0.75),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: route.color ?? Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Consumer(
                                  builder: (context, ref, _) {
                                    final passanger = ref
                                            .watch(
                                              fleetOccupancyProvider(fleet.id!),
                                            )
                                            .value ??
                                        0;

                                    return Text(
                                      '$passanger/${fleet.maxCapacity}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
