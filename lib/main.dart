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
    const ProviderScope(
      observers: [
        MyProviderObserver(),
      ],
      child: App(),
    ),
  );
}

class MyProviderObserver extends ProviderObserver {
  const MyProviderObserver();

  // @override
  // void didAddProvider(ProviderBase<Object?> provider, Object? value,
  //     ProviderContainer container) {
  //   super.didAddProvider(provider, value, container);

  //   print('didAddProvider: ${provider.name ?? provider.runtimeType}');
  // }

  // @override
  // void didDisposeProvider(
  //     ProviderBase<Object?> provider, ProviderContainer container) {
  //   super.didDisposeProvider(provider, container);
  //   print('didDisposeProvider: ${provider.name ?? provider.runtimeType}');
  // }

  // @override
  // void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
  //     Object? newValue, ProviderContainer container) {
  //   super.didUpdateProvider(provider, previousValue, newValue, container);

  //   print('didUpdateProvider: ${provider.name ?? provider.runtimeType}');
  // }
}
