// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverChatModelImpl _$$DriverChatModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverChatModelImpl(
      id: json['id'] as String?,
      message: json['message'] as String?,
      senderId: json['sender_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$DriverChatModelImplToJson(
        _$DriverChatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'sender_id': instance.senderId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
