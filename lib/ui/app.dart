import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'helpers/sizing_helper.dart';
import 'map_view.dart';
import 'providers/common/map_controller/map_provider.dart';
import 'sections/bottom_dock.dart';
import 'sections/content.dart';
import 'sections/left_bar.dart';
import 'sections/right_bar.dart';
import 'sections/top_bar.dart';
import 'themes/app_theme.dart';

// for handling with event always captured by the map,
// we need to use PointerInterceptor
// https://pub.dev/packages/pointer_interceptor
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double sidebarWidth = SizingHelper.calculateSidebarWidth(context);
    final isFocused = ref.watch(
      mapControllerProvider.select((value) => value.isFocused),
    );

    return MaterialApp(
      theme: AppTheme.theme(),
      home: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: MapView()),
            Positioned.fill(
              child: Row(
                children: [
                  SizedBox(
                    width: sidebarWidth,
                    height: double.infinity,
                    child: const LeftBar(),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: sidebarWidth,
                    height: double.infinity,
                    child: const RightBar(),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 24,
              left: 24,
              right: 24,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                  child: isFocused
                      ? const SizedBox.shrink()
                      : PointerInterceptor(child: const TopBar()),
                ),
              ),
            ),
            // content in the middle
            Positioned(
              left: 24,
              right: 24,
              top: 24,
              bottom: 24 + BottomDock.height,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                child: isFocused ? const SizedBox.shrink() : const Content(),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                child: isFocused
                    ? const SizedBox.shrink()
                    : Center(
                        child: PointerInterceptor(
                          child: const BottomDock(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
