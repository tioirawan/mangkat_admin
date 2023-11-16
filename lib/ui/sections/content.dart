import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/sizing_helper.dart';
import '../providers/common/content_window_controller/content_window_controller.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../themes/app_theme.dart';
import '../windows/driver_manager_window.dart';
import '../windows/fleet_manager_window.dart';
import '../windows/route_manager_window.dart';
import '../windows/switching_area_manager_window.dart';

class Content extends ConsumerWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = ref.watch(contentWindowProvider);

    final rightBar = ref.watch(rightSidebarContentController);
    final rightBarHasOpenWindow = rightBar.values.any((e) => e.$1);

    final content = window != null
        ? _buildContent(context, window, rightBarHasOpenWindow)
        : const SizedBox();

    return AnimatedSwitcher(
      duration: 250.milliseconds,
      reverseDuration: 250.milliseconds,
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

  Widget _buildContent(
    BuildContext context,
    ContentWindowType window,
    bool rightBarHasOpenWindow,
  ) {
    final double sidebarWidth = SizingHelper.calculateSidebarWidth(context);

    Widget content = switch (window) {
      ContentWindowType.routeManager => const RouteManagerWindow(),
      ContentWindowType.fleetManager => const FleetManagerWindow(),
      ContentWindowType.driverManager => const DriverManagerWindow(),
      ContentWindowType.switchingArea => const SwitchingAreaManagerWindow(),
    };

    double xOffset = switch (window) {
      ContentWindowType.routeManager => -145,
      ContentWindowType.fleetManager => -48,
      ContentWindowType.driverManager => 48,
      ContentWindowType.switchingArea => 145,
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedPadding(
          duration: 250.milliseconds,
          curve: Curves.easeInOut,
          padding: EdgeInsets.only(
            right: rightBarHasOpenWindow ? sidebarWidth - 24 : 0,
          ),
          child: content,
        ),
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
