import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/common/content_window_controller/content_window_controller.dart';
import 'common/table_wrapper.dart';

class DriverManagerWindow extends ConsumerWidget {
  const DriverManagerWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableWrapper(
      title: 'Driver',
      onAdd: () {},
      onClose: () => ref
          .read(contentWindowProvider.notifier)
          .toggle(ContentWindowType.driverManager),
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
