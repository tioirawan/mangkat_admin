import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/driver_model.dart';
import '../../domain/repositories/driver_repository.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/driver/drivers_provider.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_driver_window.dart';

class DriverManagerWindow extends ConsumerStatefulWidget {
  const DriverManagerWindow({super.key});

  @override
  ConsumerState<DriverManagerWindow> createState() =>
      _DriverManagerWindowState();
}

class _DriverManagerWindowState extends ConsumerState<DriverManagerWindow> {
  @override
  Widget build(BuildContext context) {
    final driversState = ref.watch(driversProvider);

    return TableWrapper(
      title: 'Pengemudi',
      onAdd: () => ref
          .read(rightSidebarContentController.notifier)
          .toggle(AddDriverWindow.name),
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.driverManager),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: driversState.when(
          data: (drivers) => _buildTable(context, drivers),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<DriverModel> drivers) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      color: colorScheme.onBackground,
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );

    final headers = [
      'Pengemudi',
      'No Telp.',
      'Alamat',
      'No. SIM',
      'Aktif Hingga',
      '',
    ];

    if (drivers.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Icon(
              Icons.person_off_rounded,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada pengemudi, silahkan tambahkan pengemudi terlebih dahulu',
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
        for (final driver in drivers)
          TableRow(
            children: [
              _buildDriverInfo(context, driver),
              Text(driver.phone ?? '-'),
              Text(driver.address ?? '-'),
              Text(driver.drivingLicenseNumber ?? '-'),
              Text(driver.drivingLicenseExpiryDate?.toString() ?? '-'),
              _buildActionButtons(context, driver),
            ],
          ),
      ],
    );
  }

  Widget _buildDriverInfo(BuildContext context, DriverModel driver) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: driver.image ?? '',
              width: 38,
              height: 38,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.person_rounded),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(driver.name ?? '-')),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, DriverModel driver) {
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
                .open(AddDriverWindow.name, driver),
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
                    'Apakah anda yakin ingin menghapus pengemudi ini?',
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
                ref.read(driverRepositoryProvider).deleteDriver(driver);
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
