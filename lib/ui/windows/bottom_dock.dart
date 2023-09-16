import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/app_theme.dart';

class BottomDock extends ConsumerWidget {
  const BottomDock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppTheme.windowCardDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            Icons.route_rounded,
            'Trayek',
            () => print('Trayek'),
          ),
          _buildButton(
            Icons.directions_bus_rounded,
            'Armada',
            () => print('Armada'),
          ),
          _buildButton(
            Icons.people_alt_rounded,
            'Pengemudi',
            () => print('Pengemudi'),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const ShapeDecoration(
                  color: Color(0xFF505050),
                  shape: OvalBorder(),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
