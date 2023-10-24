import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../themes/app_theme.dart';

class TableWrapper extends ConsumerWidget {
  const TableWrapper({
    super.key,
    required this.child,
    required this.title,
    this.onAdd,
    this.onClose,
    this.maxHeight,
    this.contentPadding,
  });

  final Widget child;
  final String title;
  final VoidCallback? onAdd;
  final VoidCallback? onClose;
  final double? maxHeight;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPadding(
      duration: 250.milliseconds,
      curve: Curves.easeInOut,
      padding: contentPadding ?? EdgeInsets.zero,
      child: AnimatedContainer(
        duration: 250.milliseconds,
        decoration: AppTheme.windowCardDecoration,
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? 300,
        ),
        child: PointerInterceptor(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    const Spacer(),
                    if (onAdd != null)
                      Material(
                        shape: const CircleBorder(),
                        color: Theme.of(context).colorScheme.primary,
                        child: InkWell(
                          onTap: onAdd,
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    if (onClose != null) ...[
                      const SizedBox(width: 8),
                      Material(
                        shape: const CircleBorder(),
                        color: Theme.of(context).colorScheme.error,
                        child: InkWell(
                          onTap: onClose,
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Divider(height: 0),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
