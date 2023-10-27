import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/route_model.dart';
import '../../domain/repositories/route_repository.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/route/routes_provider.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_route_window.dart';

class RouteManagerWindow extends ConsumerWidget {
  const RouteManagerWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: _buildTable(context, ref),
      ),
    );
  }

  Widget _buildTable(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routesProvider);

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

    return state.when(
      data: (routes) => Table(
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
                const Text('0'),
                _buildActions(context, ref, route),
              ],
            ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text(e.toString())),
    );
  }

  Widget _buildActions(
    BuildContext context,
    WidgetRef ref,
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
