import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/models/fleet_model.dart';

class FleetPill extends StatelessWidget {
  const FleetPill({
    super.key,
    required this.fleet,
    this.onClose,
  });

  final FleetModel fleet;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: fleet.image ?? '',
              width: 38,
              height: 38,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.directions_bus_rounded),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            fleet.vehicleNumber ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onClose != null) ...[
          const SizedBox(width: 8),
          IconButton(
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
            padding: EdgeInsets.zero,
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ],
    );
  }
}
