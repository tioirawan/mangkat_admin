// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FleetPositionModelImpl _$$FleetPositionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FleetPositionModelImpl(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      odometer: (json['odometer'] as num?)?.toDouble(),
      timestamp: _decodeTimestamp(json['timestamp'] as int?),
    );

Map<String, dynamic> _$$FleetPositionModelImplToJson(
        _$FleetPositionModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heading': instance.heading,
      'speed': instance.speed,
      'odometer': instance.odometer,
      'timestamp': _encodeTimestamp(instance.timestamp),
    };
