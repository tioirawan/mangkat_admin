import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      observers: [
        DebugLogger(),
      ],
      child: const App(),
    ),
  );
}

class DebugLogger extends ProviderObserver {
  DebugLogger();

  int updateCount = 0;

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);

    print('updateCount: ${++updateCount}');

    // print('''
    // Provider ${provider.name ?? provider.runtimeType} updated:
    // oldValue: $previousValue
    // newValue: $newValue
    // --------------------------------------\n\n\n
    // ''');
  }
}
