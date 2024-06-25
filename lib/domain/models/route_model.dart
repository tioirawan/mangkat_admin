// ignore_for_file: invalid_annotation_target
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

enum RouteType {
  @JsonValue('FIXED')
  fixed,
  @JsonValue('TEMPORARY')
  temporary,
}

extension RouteTypeX on RouteType {
  String get name {
    switch (this) {
      case RouteType.fixed:
        return 'TETAP';
      case RouteType.temporary:
        return 'SEMENTARA';
    }
  }
}

@freezed
class RouteModel with _$RouteModel {
  const RouteModel._();

  const factory RouteModel({
    String? id,
    String? name,
    @JsonKey(
      name: 'start_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay,
    )
    TimeOfDay? startOperation,
    @JsonKey(
      name: 'end_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay,
    )
    TimeOfDay? endOperation,
    @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) Color? color,
    RouteType? type,
    String? description,
    @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
    List<LatLng>? checkpoints,
    @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
    List<LatLng>? routes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference? reference,
  }) = _Route;

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  factory RouteModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return RouteModel.fromJson(data).copyWith(
      id: snapshot.id,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toDocument() => toJson()
    ..remove('id')
    ..remove('reference');

  double get distance {
    if (routes == null) {
      return 0;
    }

    double distance = 0;

    for (int i = 0; i < routes!.length - 1; i++) {
      distance += _calculateDistance(
        routes![i].latitude,
        routes![i].longitude,
        routes![i + 1].latitude,
        routes![i + 1].longitude,
      );
    }

    return distance;
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

List<Map<String, dynamic>> _encodeLatLngList(List<LatLng>? points) => points!
    .map((e) => {'latitude': e.latitude, 'longitude': e.longitude})
    .toList();

List<LatLng> _decodeLatLngList(List<dynamic> points) =>
    points.map((e) => LatLng(e['latitude'], e['longitude'])).toList();

// encode time of day
String _encodeTimeOfDay(TimeOfDay? time) =>
    '${time!.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

// decode time of day
TimeOfDay _decodeTimeOfDay(String? time) {
  if (time == null) {
    return TimeOfDay.now();
  }

  final parts = time.split(':');

  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}

// encode hex
String _encodeColor(Color? color) =>
    '#${color!.value.toRadixString(16).padLeft(8, '0')}';

// decode hex, shape: #FFFFFFFF
Color _decodeColor(String? hexColor) {
  if (hexColor == null) {
    return Colors.black;
  }

  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  return Color(int.parse(hexColor, radix: 16));
}
