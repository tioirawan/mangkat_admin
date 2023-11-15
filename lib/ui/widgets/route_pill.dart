import 'package:flutter/material.dart';

import '../../domain/models/route_model.dart';

class RoutePill extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      color: selected ? route.color : Colors.grey[300],
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
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
