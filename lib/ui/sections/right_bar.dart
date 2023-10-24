import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../providers/common/sections/sidebar_content_controller.dart';

class RightBar extends ConsumerWidget {
  const RightBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contents = ref.watch(rightSidebarContentController);

    return ListView(
      padding: const EdgeInsets.all(28.0).copyWith(bottom: 0),
      shrinkWrap: true,
      children: contents.keys.map((key) {
        final (isVisible, window) = contents[key]!;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
          child: isVisible
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PointerInterceptor(child: window),
                )
              : SizedBox(key: ValueKey('${key}_right_closed')),
        );
      }).toList(),
    );
  }
}
