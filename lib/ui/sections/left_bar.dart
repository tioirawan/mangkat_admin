import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../windows/statistic_window.dart';

class LeftBar extends ConsumerWidget {
  const LeftBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(28.0).copyWith(bottom: 0),
      shrinkWrap: true,
      children: [
        PointerInterceptor(child: const StatisticWindow()),
      ],
    );
  }
}
