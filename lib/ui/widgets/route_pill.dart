import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/route_model.dart';
import '../providers/common/map_controller/map_provider.dart';
import '../providers/common/sections/sidebar_content_controller.dart';
import '../providers/route/focused_route_provider.dart';
import '../windows/sidebars/route_detail_window.dart';

class RoutePill extends ConsumerWidget {
  final RouteModel route;

  final VoidCallback? onTap;
  final VoidCallback? onClose;

  final bool selected;

  const RoutePill({
    super.key,
    required this.route,
    this.onTap,
    this.onClose,
    this.selected = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: selected ? route.color : Colors.grey[300],
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap ??
            () {
              ref.read(focusedRouteProvider.notifier).state = route;
              ref
                  .read(rightSidebarContentController.notifier)
                  .open(RouteDetailWindow.name, route.id);
              ref.read(mapControllerProvider.notifier).boundTo(
                    LatLngBounds.fromPoints(route.checkpoints ?? []),
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.1,
                    ),
                  );
            },
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                route.name ?? '-',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: selected ? Colors.white : route.color,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (onClose != null) ...[
                const SizedBox(width: 4),
                InkWell(
                  onTap: onClose,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
