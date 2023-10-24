import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/common/content_window_controller/content_window_controller.dart';
import '../themes/app_theme.dart';
import '../windows/driver_manager_window copy 2.dart';
import '../windows/fleet_manager_window.dart';
import '../windows/route_manager_window.dart';

class Content extends ConsumerWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = ref.watch(contentWindowProvider);

    final content = window != null ? _buildContent(window) : const SizedBox();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 100),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1,
          // position: Tween<Offset>(
          //   begin: const Offset(0, 0.1),
          //   end: Offset.zero,
          // ).animate(animation),
          child: child,
        ),
      ),
      child: SizedBox(
        key: ValueKey(window),
        child: content,
      ),
    );
  }

  Widget _buildContent(ContentWindowType window) {
    Widget content = switch (window) {
      ContentWindowType.routeManager => const RouteManagerWindow(),
      ContentWindowType.fleetManager => const FleetManagerWindow(),
      ContentWindowType.driverManager => const DriverManagerWindow(),
    };

    double xOffset = switch (window) {
      ContentWindowType.routeManager => -103,
      ContentWindowType.fleetManager => 0,
      ContentWindowType.driverManager => 103,
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Container(
        //   decoration: AppTheme.windowCardDecoration,
        //   child: content,
        // ),
        content,
        // arrow pointing down using container
        Transform.translate(
          offset: Offset(xOffset, 0),
          child: _buildArrow(),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    const double size = 20;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Transform.rotate(
        angle: 3.14,
        child: Container(
          width: 0,
          height: 0,
          margin: const EdgeInsets.only(bottom: size),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppTheme.windowCardDecoration.color!,
                width: size,
              ),
              left: const BorderSide(
                color: Colors.transparent,
                width: size,
              ),
              right: const BorderSide(
                color: Colors.transparent,
                width: size,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
