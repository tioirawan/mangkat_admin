import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../domain/models/fleet_model.dart';
import '../providers/driver/driver_provider.dart';
import '../providers/fleet/fleets_provider.dart';
import '../providers/route/route_provider.dart';
import '../themes/app_theme.dart';
import 'driver_pill.dart';
import 'fleet_pill.dart';
import 'fleet_status_pill.dart';
import 'route_pill.dart';

enum FleetSelectionRecommendationLevel {
  stronglyRecommended,
  recommended,
  notRecommended,
  none
}

FleetSelectionRecommendationLevel getFleetSelectionRecommendationLevel(
  FleetModel fleet,
  String? forRouteId,
) {
  // if already assigned to the route, mark is as none
  if (fleet.routeId == forRouteId) {
    return FleetSelectionRecommendationLevel.none;
  } else if (fleet.routeId == null) {
    if (fleet.driverId != null) {
      return FleetSelectionRecommendationLevel.stronglyRecommended;
    } else {
      return FleetSelectionRecommendationLevel.recommended;
    }
  } else {
    return FleetSelectionRecommendationLevel.notRecommended;
  }
}

class FleetSelectorPopup extends ConsumerStatefulWidget {
  /// With this, we can recommend which fleets to select
  final String? forRouteId;
  final List<String> selectedFleetIds;

  const FleetSelectorPopup({
    super.key,
    this.forRouteId,
    this.selectedFleetIds = const [],
  });

  static Future<List<String>> show(
    BuildContext context, {
    List<String> selected = const [],
    String? forRouteId,
  }) async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: FleetSelectorPopup(
          selectedFleetIds: selected,
          forRouteId: forRouteId,
        ),
      ),
    );

    return result ?? [];
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FleetSelectorPopupState();
}

class _FleetSelectorPopupState extends ConsumerState<FleetSelectorPopup> {
  late final List<String> _selectedFleetIds = widget.selectedFleetIds;

  String searchQuery = '';

  List<FleetModel> _applyFilter(List<FleetModel> fleets) {
    return fleets.where(
      (element) {
        if (searchQuery.isEmpty) {
          return true;
        }

        return element.vehicleNumber
                ?.toLowerCase()
                .contains(searchQuery.toLowerCase()) ??
            false;
      },
    ).toList()
      ..sort((a, b) {
        if (a.routeId == widget.forRouteId && b.routeId != widget.forRouteId) {
          return -1; // Place a at the top
        } else if (a.routeId != widget.forRouteId &&
            b.routeId == widget.forRouteId) {
          return 1; // Place b at the top
        } else if (a.routeId == widget.forRouteId &&
            b.routeId == widget.forRouteId) {
          // If both have the same routeId, compare them using their vehicle numbers
          return a.vehicleNumber!.compareTo(b.vehicleNumber!);
        } else if (a.routeId == null && b.routeId != null) {
          return -1; // Place a at the second rank
        } else if (a.routeId != null && b.routeId == null) {
          return 1; // Place b at the second rank
        } else if (a.routeId != null && b.routeId != null) {
          // If both have non-null routeId values, compare them based on routeId
          return a.routeId!.compareTo(b.routeId!);
        } else if (a.routeId == null || b.routeId == null) {
          // If both have null routeId values, compare them using their vehicle numbers
          return a.vehicleNumber!.compareTo(b.vehicleNumber!);
        } else {
          return 0;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final fleets = ref.watch(fleetsProvider);

    return PointerInterceptor(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: AppTheme.windowCardDecoration,
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pilih Armada',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        // close button
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Pilih armada yang akan ditambahkan ke trayek ini',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Cari armada',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildLegend(context),
                  ],
                ),
              ),
              fleets.when(
                data: (fleets) => _buildFleetsList(
                  context,
                  _applyFilter(fleets),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (e, s) => Center(
                  child: Text(e.toString()),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(_selectedFleetIds),
                    child: const Text('Simpan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFleetsList(BuildContext context, List<FleetModel> fleets) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: fleets.length,
        itemBuilder: (context, index) {
          final fleet = fleets[index];
          final recommendationLevel =
              getFleetSelectionRecommendationLevel(fleet, widget.forRouteId);

          Color bgColor = _getRecommendationColor(recommendationLevel);

          return Consumer(builder: (context, ref, _) {
            final route = ref.watch(routeProvider(fleet.routeId));
            final driver = ref.watch(driverProvider(fleet.driverId));

            return Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 18,
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: FleetPill(
                        fleet: fleet,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FleetStatusPill(fleet: fleet),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: route != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: RoutePill(
                                route: route,
                              ),
                            )
                          : Text(
                              'Belum ada trayek',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: driver != null
                          ? DriverPill(
                              driver: driver,
                            )
                          : Text(
                              'Belum ada pengemudi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                    ),
                  ],
                ),
                trailing: Checkbox(
                  value: _selectedFleetIds.contains(fleet.id),
                  onChanged: (value) {
                    if (value == true) {
                      _selectedFleetIds.add(fleet.id!);
                    } else {
                      _selectedFleetIds.remove(fleet.id);
                    }

                    setState(() {});
                  },
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Color _getRecommendationColor(
      FleetSelectionRecommendationLevel recommendationLevel) {
    return switch (recommendationLevel) {
      FleetSelectionRecommendationLevel.stronglyRecommended =>
        const Color.fromARGB(116, 169, 255, 168),
      FleetSelectionRecommendationLevel.recommended =>
        const Color.fromARGB(118, 255, 243, 168),
      FleetSelectionRecommendationLevel.notRecommended =>
        const Color.fromARGB(117, 255, 168, 168),
      FleetSelectionRecommendationLevel.none => Colors.transparent,
    };
  }

  Widget _buildLegend(BuildContext context) {
    final legends = {
      _getRecommendationColor(
              FleetSelectionRecommendationLevel.stronglyRecommended):
          'Sangat direkomendasikan',
      _getRecommendationColor(FleetSelectionRecommendationLevel.recommended):
          'Direkomendasikan',
      _getRecommendationColor(FleetSelectionRecommendationLevel.notRecommended):
          'Tidak direkomendasikan',
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: legends.entries.map((e) {
        return Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: e.key,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              e.value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 16),
          ],
        );
      }).toList(),
    );
  }
}
