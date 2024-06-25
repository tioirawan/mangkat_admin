import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/models/driver_model.dart';

class DriverPill extends StatelessWidget {
  final DriverModel driver;

  const DriverPill({
    super.key,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CircleAvatar(
            radius: 12,
            backgroundImage: CachedNetworkImageProvider(driver.image ?? ''),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(driver.name ?? '')),
      ],
    );
  }
}
