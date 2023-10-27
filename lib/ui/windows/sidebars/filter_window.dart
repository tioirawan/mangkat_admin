import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter/filter_provider.dart';
import '../../providers/route/routes_provider.dart';
import '../../themes/app_theme.dart';

class FilterWindow extends ConsumerStatefulWidget {
  static const String name = 'window/filter';

  const FilterWindow({
    super.key,
  });

  @override
  ConsumerState<FilterWindow> createState() => _StatisticWindowState();
}

class _StatisticWindowState extends ConsumerState<FilterWindow> {
  bool _isMinimized = false;

  @override
  Widget build(BuildContext context) {
    final routesState = ref.watch(routesProvider);
    final routeFilter = ref.watch(routeFilterProvider);

    return AnimatedSwitcher(
      duration: 200.milliseconds,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      ),
      child: _isMinimized
          ? Material(
              elevation: 1,
              color: Theme.of(context).colorScheme.surface,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => setState(() => _isMinimized = false),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.filter_list),
                ),
              ),
            )
          : Container(
              decoration: AppTheme.windowCardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        CloseButton(
                          onPressed: () => setState(() => _isMinimized = true),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Trayek',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        routesState.when(
                          data: (routes) => routes
                                  .map((e) => e.name)
                                  .toList()
                                  .isEmpty
                              ? const Center(child: Text('Tidak ada trayek'))
                              : Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    FilterChip(
                                      label: const Text(
                                        'Semua',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      selectedColor:
                                          Theme.of(context).colorScheme.primary,
                                      showCheckmark: false,
                                      selected: routeFilter.isEmpty ||
                                          routeFilter.length == routes.length,
                                      onSelected: (selected) {
                                        ref
                                            .read(routeFilterProvider.notifier)
                                            .selectAll(
                                              routes.map((e) => e.id!).toList(),
                                            );
                                      },
                                    ),
                                    for (final route in routes)
                                      FilterChip(
                                        label: Text(
                                          route.name ?? '',
                                          style: TextStyle(
                                            color:
                                                routeFilter.contains(route.id)
                                                    ? Colors.white
                                                    : route.color,
                                          ),
                                        ),
                                        selected:
                                            routeFilter.contains(route.id),
                                        selectedColor: route.color,
                                        showCheckmark: false,
                                        onSelected: (selected) {
                                          if (selected) {
                                            ref
                                                .read(routeFilterProvider
                                                    .notifier)
                                                .add(route.id!);
                                          } else {
                                            ref
                                                .read(routeFilterProvider
                                                    .notifier)
                                                .remove(route.id!);
                                          }
                                        },
                                      )
                                  ],
                                ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, s) => Center(child: Text(e.toString())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
