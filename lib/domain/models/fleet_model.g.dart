// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FleetModelImpl _$$FleetModelImplFromJson(Map<String, dynamic> json) =>
    _$FleetModelImpl(
      id: json['id'] as String?,
      vehicleNumber: json['vehicleNumber'] as String?,
      image: json['image'] as String?,
      status: $enumDecodeNullable(_$FleetStatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$FleetTypeEnumMap, json['type']),
      notes: json['notes'] as String?,
      maxCapacity: json['max_capacity'] as int?,
      driverId: json['driver_id'] as String?,
      routeId: json['route_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$FleetModelImplToJson(_$FleetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleNumber': instance.vehicleNumber,
      'image': instance.image,
      'status': _$FleetStatusEnumMap[instance.status],
      'type': _$FleetTypeEnumMap[instance.type],
      'notes': instance.notes,
      'max_capacity': instance.maxCapacity,
      'driver_id': instance.driverId,
      'route_id': instance.routeId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$FleetStatusEnumMap = {
  FleetStatus.idle: 'idle',
  FleetStatus.operating: 'operating',
  FleetStatus.rented: 'rented',
  FleetStatus.maintenance: 'maintenance',
  FleetStatus.broken: 'broken',
  FleetStatus.unknown: 'unknown',
};

const _$FleetTypeEnumMap = {
  FleetType.miniBus: 'mini_bus',
  FleetType.mediumBus: 'medium_bus',
  FleetType.bigBus: 'big_bus',
  FleetType.other: 'other',
};
