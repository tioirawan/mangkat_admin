import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/switching_area_model.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/route/route_provider.dart';
import '../providers/switching_area/switching_area_controller.dart';
import '../providers/switching_area/switching_areas_provider.dart';
import '../widgets/route_pill.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_switching_area_window.dart';

class SwitchingAreaManagerWindow extends ConsumerStatefulWidget {
  const SwitchingAreaManagerWindow({super.key});

  @override
  ConsumerState<SwitchingAreaManagerWindow> createState() =>
      _SwitchingAreaManagerWindowState();
}

class _SwitchingAreaManagerWindowState
    extends ConsumerState<SwitchingAreaManagerWindow> {
  @override
  Widget build(BuildContext context) {
    final switchingAreaState = ref.watch(switchingAreasProvider);

    return TableWrapper(
      title: 'Switching Area',
      subtitle:
          'Area dimana armada dapat dipindahkan ke trayek lain secara otomatis oleh sistem load balancer',
      onAdd: () => ref
          .read(rightSidebarContentController.notifier)
          .toggle(AddSwitchingAreaWindow.name),
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.switchingArea),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: switchingAreaState.when(
          data: (switchingArea) => _buildTable(context, switchingArea),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              '$error',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTable(
      BuildContext context, List<SwitchingAreaModel> switchingAreas) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      color: colorScheme.onBackground,
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );

    final headers = [
      'Nama',
      'Trayek',
      '',
    ];

    if (switchingAreas.isEmpty) {
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
        for (final switchingArea in switchingAreas)
          TableRow(
            children: [
              Text(switchingArea.name ?? '-'),
              Wrap(
                spacing: 8,
                children: [
                  for (final routeId in switchingArea.routes ?? [])
                    Consumer(
                      builder: (context, ref, _) {
                        final route = ref.watch(routeProvider(routeId));

                        if (route == null) return const SizedBox();

                        return RoutePill(route: route);
                      },
                    )
                ],
              ),
              _buildActionButtons(context, switchingArea),
            ],
          ),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context, SwitchingAreaModel switchingArea) {
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
                .open(AddSwitchingAreaWindow.name, switchingArea),
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
                ref.read(switchingAreaControllerProvider).delete(switchingArea);
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
