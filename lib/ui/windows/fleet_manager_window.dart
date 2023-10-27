import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/fleet_model.dart';
import '../../domain/repositories/fleet_repository.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/fleet/fleets_provider.dart';
import '../providers/route/route_provider.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_fleet_window.dart';

class FleetManagerWindow extends ConsumerStatefulWidget {
  const FleetManagerWindow({super.key});

  @override
  ConsumerState<FleetManagerWindow> createState() => _FleetManagerWindowState();
}

class _FleetManagerWindowState extends ConsumerState<FleetManagerWindow> {
  @override
  Widget build(BuildContext context) {
    final fleetsState = ref.watch(fleetsProvider);

    return TableWrapper(
      title: 'Armada',
      onAdd: () => ref
          .read(rightSidebarContentController.notifier)
          .toggle(AddFleetWindow.name),
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.fleetManager),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: fleetsState.when(
          data: (fleets) => _buildTable(context, fleets),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<FleetModel> fleets) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      color: colorScheme.onBackground,
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );

    final headers = [
      'Nomor Kendaraan',
      'Status',
      'Jenis',
      'Catatan',
      'Trayek',
      'Pengemudi',
      '',
    ];

    if (fleets.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Icon(
              Icons.directions_bus_rounded,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada armada, silahkan tambahkan armada terlebih dahulu',
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
        for (final fleet in fleets)
          TableRow(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: fleet.image ?? '',
                      width: 38,
                      height: 38,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.directions_bus_rounded),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(fleet.vehicleNumber ?? '')),
                ],
              ),
              _buildStatus(fleet),
              Text(fleet.type?.name ?? ''),
              Text(fleet.notes ?? ''),
              _buildFleetRoute(fleet),
              _buildFleetDriver(fleet),
              _buildActionButtons(context, fleet),
            ],
          ),
      ],
    );
  }

  Widget _buildStatus(FleetModel fleet) {
    final color = switch (fleet.status) {
      FleetStatus.idle => const Color.fromARGB(255, 181, 181, 181),
      FleetStatus.operating => const Color(0xff27ae60),
      FleetStatus.rented => const Color(0xff2980b9),
      FleetStatus.maintenance => const Color(0xfff1c40f),
      FleetStatus.broken => const Color.fromARGB(255, 255, 95, 95),
      FleetStatus.unknown => const Color.fromARGB(255, 181, 181, 181),
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
          fleet.status?.name ?? '',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
        ),
      ),
    );
  }

  Widget _buildFleetDriver(FleetModel fleet) {
    return Text(
      fleet.driverRef ?? 'Belum ada pengemudi',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontStyle:
                fleet.driverRef == null ? FontStyle.italic : FontStyle.normal,
          ),
    );
  }

  Widget _buildFleetRoute(FleetModel fleet) {
    final route = ref.watch(routeProvider(fleet.routeRef));

    if (route == null) {
      return const Text('-');
    }

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: route.color ?? Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(route.name ?? ''),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, FleetModel fleet) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          borderRadius: BorderRadius.circular(4),
          color: colorScheme.primary,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => ref
                .read(rightSidebarContentController.notifier)
                .open(AddFleetWindow.name, fleet),
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
                    'Apakah anda yakin ingin menghapus armada ini?',
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
                ref.read(fleetRepositoryProvider).deleteFleet(fleet);
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
    );
  }
}
