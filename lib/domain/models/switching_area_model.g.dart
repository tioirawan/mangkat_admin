// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switching_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SwitchingAreaImpl _$$SwitchingAreaImplFromJson(Map<String, dynamic> json) =>
    _$SwitchingAreaImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      routes:
          (json['routes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SwitchingAreaImplToJson(_$SwitchingAreaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
      'routes': instance.routes,
    };
