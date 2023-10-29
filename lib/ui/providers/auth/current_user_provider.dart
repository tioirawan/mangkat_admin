import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/services/firebase_service.dart';

final userProvider = StreamProvider<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});
