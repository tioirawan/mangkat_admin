// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteImpl _$$RouteImplFromJson(Map<String, dynamic> json) => _$RouteImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      startOperation: json['start_operation'] as String?,
      endOperation: json['end_operation'] as String?,
      color: _decodeColor(json['color'] as String?),
      type: json['type'] as String?,
      description: json['description'] as String?,
      checkpoints: _decodeLatLngList(json['checkpoints'] as List),
      routes: _decodeLatLngList(json['routes'] as List),
    );

Map<String, dynamic> _$$RouteImplToJson(_$RouteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_operation': instance.startOperation,
      'end_operation': instance.endOperation,
      'color': _encodeColor(instance.color),
      'type': instance.type,
      'description': instance.description,
      'checkpoints': _encodeLatLngList(instance.checkpoints),
      'routes': _encodeLatLngList(instance.routes),
    };
