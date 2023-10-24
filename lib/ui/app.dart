import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'map_view.dart';
import 'sections/bottom_dock.dart';
import 'sections/content.dart';
import 'sections/left_bar.dart';
import 'sections/right_bar.dart';
import 'sections/top_bar.dart';
import 'themes/app_theme.dart';

// for handling with event always captured by the map,
// we need to use PointerInterceptor
// https://pub.dev/packages/pointer_interceptor
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double sidebarWidth = min(400, width * 0.3);

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
              child: Center(child: PointerInterceptor(child: const TopBar())),
            ),
            // content in the middle
            const Positioned(
              left: 24,
              right: 24,
              top: 24,
              bottom: 24 + BottomDock.height,
              child: Content(),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Center(
                child: PointerInterceptor(
                  child: const BottomDock(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
