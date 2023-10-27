import 'package:flutter/material.dart';

import '../../domain/models/route_model.dart';

class RoutePill extends StatelessWidget {
  final RouteModel route;

  const RoutePill({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: route.color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        route.name ?? '-',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
