import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/sizing_helper.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import 'common/table_wrapper.dart';
import 'sidebars/add_route_window.dart';

class RouteManagerWindow extends ConsumerWidget {
  const RouteManagerWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rightBar = ref.watch(rightSidebarContentController);
    final double sidebarWidth = SizingHelper.calculateSidebarWidth(context);

    return TableWrapper(
      title: 'Trayek',
      contentPadding: EdgeInsets.only(
        right: rightBar[AddRouteWindow.name]!.$1 ? sidebarWidth - 24 : 0,
      ),
      onAdd: () {
        ref
            .read(rightSidebarContentController.notifier)
            .toggle(AddRouteWindow.name);
      },
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.routeManager),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _buildTable(context),
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
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
        for (int i = 0; i < 100; i++)
          const TableRow(
            children: [
              Text('Nama Trayek'),
              Text('Mulai Operasi'),
              Text('Selesai Operasi'),
              Text('Warna'),
              Text('Jenis'),
              Text('Deskripsi'),
              Text('Armada Beroperasi'),
              SizedBox(height: 38, width: 100),
            ],
          ),
      ],
    );
  }
}
