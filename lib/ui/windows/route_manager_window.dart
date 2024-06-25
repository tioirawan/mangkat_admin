import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/fleet_model.dart';
import '../../domain/models/route_model.dart';
import '../../domain/repositories/route_repository.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/map_controller/map_provider.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/route/focused_route_provider.dart';
import '../providers/route/route_fleets_provider.dart';
import '../providers/route/routes_provider.dart';
import '../widgets/route_pill.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_route_window.dart';

class RouteManagerWindow extends ConsumerStatefulWidget {
  const RouteManagerWindow({super.key});

  @override
  ConsumerState<RouteManagerWindow> createState() => _RouteManagerWindowState();
}

class _RouteManagerWindowState extends ConsumerState<RouteManagerWindow> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(routesProvider);

    return TableWrapper(
      title: 'Trayek',
      onAdd: () => ref
          .read(rightSidebarContentController.notifier)
          .toggle(AddRouteWindow.name),
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.routeManager),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: state.when(
          data: (routes) => _buildTable(context, routes),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text(e.toString())),
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<RouteModel> routes) {
    final focusedRoute = ref.watch(focusedRouteProvider);

    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      color: colorScheme.onBackground,
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );

    final headers = [
      'Nama Trayek',
      'Panjang Trayek',
      'Mulai Operasi',
      'Selesai Operasi',
      'Jenis',
      'Deskripsi',
      'Armada Beroperasi',
      '',
    ];

    if (routes.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Icon(
              Icons.route_rounded,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada trayek, silahkan tambahkan trayek terlebih dahulu',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: headers
              .map(
                (header) => SizedBox(
                  height: 38,
                  child: Text(header, style: headerStyle),
                ),
              )
              .toList(),
        ),
        for (final route in routes)
          TableRow(
            decoration: BoxDecoration(
              color: route.id == focusedRoute?.id
                  ? colorScheme.primary.withOpacity(0.1)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            children: [
              _buildRouteName(route),
              Text('${route.distance.toStringAsFixed(2)} km'),
              Text(route.startOperation?.format(context) ?? '-'),
              Text(route.endOperation?.format(context) ?? '-'),
              _buildRouteType(route),
              Text(
                route.description ?? '-',
                overflow: TextOverflow.ellipsis,
              ),
              _buildStatus(context, route),
              _buildActions(context, route, route.id == focusedRoute?.id),
            ],
          ),
      ],
    );
  }

  Widget _buildRouteType(RouteModel route) {
    final color = switch (route.type) {
      RouteType.fixed => const Color(0xff27ae60),
      RouteType.temporary => const Color(0xff2980b9),
      _ => const Color.fromARGB(255, 181, 181, 181),
    };

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          route.type?.name ?? '',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
        ),
      ),
    );
  }

  Widget _buildRouteName(RouteModel route) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RoutePill(route: route),
      ),
    );
  }

  Widget _buildStatus(
    BuildContext context,
    RouteModel route,
  ) {
    final fleets = ref.watch(routeFleetNumberProvider(route));
    final operatingFleets =
        fleets.where((fleet) => fleet.status == FleetStatus.operating).toList();
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '${operatingFleets.length} / ${fleets.length}',
            style: TextStyle(
              color: colorScheme.onBackground,
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.directions_bus_rounded,
          size: 16,
          color: colorScheme.onBackground,
        ),
      ],
    );
  }

  Widget _buildActions(
    BuildContext context,
    RouteModel route,
    bool isFocused,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(4),
            color: colorScheme.tertiary,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                if (!isFocused) {
                  ref.read(focusedRouteProvider.notifier).state = route;
                  ref
                      .read(mapControllerProvider.notifier)
                      .boundTo(LatLngBounds.fromPoints(route.routes!));
                } else {
                  ref.read(focusedRouteProvider.notifier).state = null;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isFocused ? Icons.close : Icons.remove_red_eye_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            borderRadius: BorderRadius.circular(4),
            color: colorScheme.primary,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => ref
                  .read(rightSidebarContentController.notifier)
                  .open(AddRouteWindow.name, route),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            borderRadius: BorderRadius.circular(4),
            color: colorScheme.error,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const Text(
                      'Apakah anda yakin ingin menghapus trayek ini?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );

                if (confirm ?? false) {
                  ref.read(routeRepositoryProvider).deleteRoute(route);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
