import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/load_balancer/load_balancer_controller.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class LoadBalancerWindow extends ConsumerStatefulWidget {
  static const String name = 'window/load-balancer';

  const LoadBalancerWindow({
    super.key,
  });

  @override
  ConsumerState<LoadBalancerWindow> createState() =>
      _OrchestrationWindowState();
}

class _OrchestrationWindowState extends ConsumerState<LoadBalancerWindow> {
  bool _isMinimized = false;

  @override
  Widget build(BuildContext context) {
    final isLoadBalancerActive = ref.watch(isLoadBalancerActiveProvider);
    final orchestration = ref.watch(loadBalancerProvider);

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
                customBorder: const CircleBorder(),
                onTap: () => setState(() => _isMinimized = false),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.balance_rounded),
                ),
              ),
            )
          : Container(
              decoration: AppTheme.windowCardDecoration,
              constraints: const BoxConstraints(maxHeight: 650),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Load Balancer',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  'Otomatisasi penentuan trayek armada',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Switch(
                            value: isLoadBalancerActive,
                            onChanged: (value) {
                              ref
                                  .read(isLoadBalancerActiveProvider.notifier)
                                  .state = value;
                            },
                          ),
                          CloseButton(
                            onPressed: () =>
                                setState(() => _isMinimized = true),
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
                          for (final key in orchestration.keys)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RoutePill(route: key),
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildRouteOccupancy(
                                        orchestration[key]!.totalCapacity,
                                        orchestration[key]!.totalPassengers,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Divider(
                                  height: 0,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildRouteOccupancy(int capacity, int occupancy) {
    final percentage = capacity == 0 ? 0 : occupancy / capacity * 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$occupancy/$capacity (${percentage.toStringAsFixed(0)}%)',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder(
          duration: 1.seconds,
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: capacity > 0 ? occupancy / capacity : 0,
          ),
          builder: (context, value, _) {
            const safeOccupancyTreshold = 0.8;

            const Color safeOccupancy = Colors.green;
            const Color dangerOccupancy = Colors.red;

            return LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                value < safeOccupancyTreshold
                    ? safeOccupancy
                    : Color.lerp(
                        safeOccupancy,
                        dangerOccupancy,
                        (value - safeOccupancyTreshold) /
                            (1 - safeOccupancyTreshold),
                      )!,
              ),
              minHeight: 12,
              borderRadius: BorderRadius.circular(999),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            );
          },
        ),
      ],
    );
  }
}
