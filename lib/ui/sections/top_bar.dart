import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/date_helper.dart';
import '../themes/app_theme.dart';

class TopBar extends ConsumerStatefulWidget {
  const TopBar({super.key});

  @override
  ConsumerState<TopBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<TopBar>
    with SingleTickerProviderStateMixin {
  // animation that thick every second
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: AppTheme.windowCardDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sunny, color: Colors.orange),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Text(
              DateHelper.format(DateTime.now()),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
