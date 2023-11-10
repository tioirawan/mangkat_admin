import 'package:flutter/material.dart';

import '../../domain/models/fleet_model.dart';

class FleetStatusPill extends StatelessWidget {
  const FleetStatusPill({
    super.key,
    required this.fleet,
  });

  final FleetModel fleet;

  @override
  Widget build(BuildContext context) {
    final color = switch (fleet.status) {
      FleetStatus.idle => const Color.fromARGB(255, 181, 181, 181),
      FleetStatus.operating => const Color(0xff27ae60),
      FleetStatus.rented => const Color(0xff2980b9),
      FleetStatus.maintenance => const Color(0xfff1c40f),
      FleetStatus.broken => const Color.fromARGB(255, 255, 95, 95),
      FleetStatus.unknown => const Color.fromARGB(255, 181, 181, 181),
      _ => const Color.fromARGB(255, 181, 181, 181),
    };
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          fleet.status?.name ?? '',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
        ),
      ),
    );
  }
}
