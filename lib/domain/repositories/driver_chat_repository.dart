import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/driver_chat_repository_impl.dart';
import '../models/driver_chat_model.dart';
import '../services/firebase_service.dart';

abstract class DriverChatRepository {
  Stream<List<DriverChatModel>> driverChatsStream(String driverId);
  Future<List<DriverChatModel>> getDriverChats(String driverId);
  Future<DriverChatModel> createDriverChat(
    String driverId,
    DriverChatModel driverChat,
  );
}

final driverChatRepositoryProvider = Provider<DriverChatRepository>(
  (ref) => DriverChatRepositoryImpl(
    ref.watch(firestoreProvider),
  ),
);
