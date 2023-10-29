import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/driver_chat_model.dart';
import '../../../domain/repositories/driver_chat_repository.dart';
import '../auth/current_user_provider.dart';

typedef DriverChatState = AsyncValue<List<DriverChatModel>>;

final driverChatProvider = StateNotifierProvider.family
    .autoDispose<DriverChatNotifier, DriverChatState, String?>((ref, driverId) {
  final adminId = ref.watch(userProvider).asData?.value?.uid;

  final driverChatRepository = ref.watch(driverChatRepositoryProvider);

  return DriverChatNotifier(
    driverChatRepository,
    driverId,
    adminId,
  );
});

class DriverChatNotifier extends StateNotifier<DriverChatState> {
  final DriverChatRepository _driverChatRepository;
  final String? _driverId;
  final String? _adminId;

  StreamSubscription<List<DriverChatModel>>? _driverChatSubscription;

  DriverChatNotifier(
    this._driverChatRepository,
    this._driverId,
    this._adminId,
  ) : super(const AsyncValue.loading()) {
    if (_driverId != null) {
      _init();
    }
  }

  Future<void> _init() async {
    try {
      _driverChatSubscription?.cancel();
      _driverChatSubscription = _driverChatRepository
          .driverChatsStream(_driverId!)
          .listen((driverChats) {
        driverChats.sort(
          (a, b) {
            if (a.createdAt == null || b.createdAt == null) {
              return 0;
            }

            return b.createdAt!.compareTo(a.createdAt!);
          },
        );
        state = AsyncValue.data(driverChats);
      });
    } on FirebaseException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> send(String message) async {
    try {
      if (_driverId == null || _adminId == null) {
        return;
      }

      final driverChat = DriverChatModel(
        message: message,
        senderId: _adminId!,
        createdAt: DateTime.now(),
      );

      await _driverChatRepository.createDriverChat(_driverId!, driverChat);
    } on FirebaseException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _driverChatSubscription?.cancel();
    super.dispose();
  }
}
