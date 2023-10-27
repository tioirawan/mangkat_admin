import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/fleet_model.dart';
import '../../domain/models/route_model.dart';
import '../../domain/repositories/route_repository.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/route/route_fleets_provider.dart';
import '../providers/route/routes_provider.dart';
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
      'Mulai Operasi',
      'Selesai Operasi',
      'Warna',
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
            children: [
              Text(route.name ?? '-'),
              Text(route.startOperation ?? '-'),
              Text(route.endOperation ?? '-'),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: route.color ?? Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(route.type ?? '-'),
              Text(
                route.description ?? '-',
                overflow: TextOverflow.ellipsis,
              ),
              _buildStatus(context, route),
              _buildActions(context, route),
            ],
          ),
      ],
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
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
