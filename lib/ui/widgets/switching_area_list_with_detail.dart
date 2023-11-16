import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/load_balancer/load_balancer_service_provider.dart';
import '../providers/switching_area/switching_areas_provider.dart';
import '../windows/sidebars/switching_area_detail_window.dart';

class SwitchingAreaListWithDetail extends ConsumerWidget {
  const SwitchingAreaListWithDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchingAreasState = ref.watch(switchingAreasProvider);

    return switchingAreasState.when(
      data: (switchingAreas) => Column(
        children: [
          for (final switchingArea in switchingAreas)
            Row(
              children: [
                Expanded(
                  child: Text(
                    switchingArea.name ?? '-',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Consumer(builder: (context, ref, _) {
                  // final fleets = ref.watch(
                  //   switchingAreaFreeFleetsProvider(switchingArea.id),
                  // );
                  final isLoadBalancerActive = ref.watch(
                    isLoadBalancerActiveProvider(switchingArea.id),
                  );

                  return Switch(
                    value: isLoadBalancerActive,
                    onChanged: (value) {
                      ref
                          .read(isLoadBalancerActiveProvider(switchingArea.id)
                              .notifier)
                          .state = value;

                      final loadBalancer = ref
                          .read(loadBalancerServiceProvider(switchingArea.id));

                      if (value) {
                        loadBalancer?.start();
                      } else {
                        loadBalancer?.stop();
                      }
                    },
                  );
                }),
                const SizedBox(height: 8),
                IconButton(
                  onPressed: () => ref
                      .read(rightSidebarContentController.notifier)
                      .open(SwitchingAreaDetailWindow.name, switchingArea.id),
                  icon: Icon(
                    Icons.remove_red_eye_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
              ],
            )
        ],
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
