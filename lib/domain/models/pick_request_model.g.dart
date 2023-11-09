// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickRequestModelImpl _$$PickRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickRequestModelImpl(
      id: json['id'] as String?,
      routeId: json['route_id'] as String?,
      userId: json['user_id'] as String?,
      fleetId: json['fleet_id'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      picked: json['picked'] as bool? ?? false,
      pickedAt: json['picked_at'] == null
          ? null
          : DateTime.parse(json['picked_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PickRequestModelImplToJson(
        _$PickRequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'route_id': instance.routeId,
      'user_id': instance.userId,
      'fleet_id': instance.fleetId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'picked': instance.picked,
      'picked_at': instance.pickedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
