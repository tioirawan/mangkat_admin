import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/common/content_window_controller/content_window_controller.dart';
import '../themes/app_theme.dart';

class BottomDock extends ConsumerWidget {
  static const double height = 18 * 2 + 46 + 8 + 10;
  static const double width = 420;

  const BottomDock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = ref.watch(contentWindowProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppTheme.windowCardDecoration,
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            context,
            Icons.route_rounded,
            'Trayek',
            window == ContentWindowType.routeManager,
            () => ref
                .read(contentWindowProvider.notifier)
                .toggle(ContentWindowType.routeManager),
          ),
          _buildButton(
            context,
            Icons.directions_bus_rounded,
            'Armada',
            window == ContentWindowType.fleetManager,
            () => ref
                .read(contentWindowProvider.notifier)
                .toggle(ContentWindowType.fleetManager),
          ),
          _buildButton(
            context,
            Icons.people_alt_rounded,
            'Pengemudi',
            window == ContentWindowType.driverManager,
            () => ref
                .read(contentWindowProvider.notifier)
                .toggle(ContentWindowType.driverManager),
          ),
          _buildButton(
            context,
            Icons.switch_access_shortcut,
            'Switching',
            window == ContentWindowType.switchingArea,
            () => ref
                .read(contentWindowProvider.notifier)
                .toggle(ContentWindowType.switchingArea),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  width: 46,
                  height: 46,
                  duration: 200.milliseconds,
                  decoration: ShapeDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : const Color(0xFF505050),
                    shape: const OvalBorder(),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : const Color(0xFF505050),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
