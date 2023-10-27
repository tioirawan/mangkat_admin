import 'package:flutter/material.dart';

import '../../domain/models/route_model.dart';

class RoutePill extends StatelessWidget {
  final RouteModel route;

  final VoidCallback? onTap;
  final VoidCallback? onClose;

  const RoutePill({
    super.key,
    required this.route,
    this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: route.color,
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
                      color: Colors.white,
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
