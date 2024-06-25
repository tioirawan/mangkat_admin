import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/driver_chat_model.dart';
import '../../domain/repositories/driver_chat_repository.dart';

class DriverChatRepositoryImpl implements DriverChatRepository {
  final FirebaseFirestore _firestore;

  DriverChatRepositoryImpl(this._firestore);

  CollectionReference _chats(String driverId) =>
      _firestore.collection('drivers').doc(driverId).collection('admin_chats');

  @override
  Future<DriverChatModel> createDriverChat(
      String driverId, DriverChatModel driverChat) async {
    final doc = await _chats(driverId).add(driverChat.toDocument());

    return driverChat.copyWith(
      id: doc.id,
      reference: doc,
    );
  }

  @override
  Stream<List<DriverChatModel>> driverChatsStream(String driverId) {
    return _chats(driverId).snapshots().map(
        (snapshot) => snapshot.docs.map(DriverChatModel.fromSnapshot).toList());
  }

  @override
  Future<List<DriverChatModel>> getDriverChats(String driverId) async {
    final snapshot = await _chats(driverId).get();
    return snapshot.docs.map((e) => DriverChatModel.fromSnapshot(e)).toList();
  }
}
