import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'content_window_type.dart';

final contentWindowProvider =
    StateNotifierProvider<ContentWindowNotifier, ContentWindowType?>(
  (_) => ContentWindowNotifier(),
);

class ContentWindowNotifier extends StateNotifier<ContentWindowType?> {
  ContentWindowNotifier() : super(null);

  void toggle(ContentWindowType window) {
    if (window == state) {
      state = null;
    } else {
      state = window;
    }
  }
}
