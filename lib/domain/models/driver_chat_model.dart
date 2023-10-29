// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_chat_model.freezed.dart';
part 'driver_chat_model.g.dart';

@freezed
class DriverChatModel with _$DriverChatModel {
  const DriverChatModel._();

  factory DriverChatModel({
    String? id,
    String? message,
    @JsonKey(name: 'sender_id') String? senderId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference? reference,
  }) = _DriverChatModel;

  factory DriverChatModel.fromJson(Map<String, dynamic> json) =>
      _$DriverChatModelFromJson(json);

  factory DriverChatModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return DriverChatModel.fromJson(data).copyWith(
      id: snapshot.id,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toDocument() => toJson()
    ..remove('id')
    ..remove('reference');
}
