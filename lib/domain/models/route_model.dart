// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
class RouteModel with _$RouteModel {
  const RouteModel._();

  const factory RouteModel({
    String? id,
    String? name,
    @JsonKey(name: 'start_operation') String? startOperation,
    @JsonKey(name: 'end_operation') String? endOperation,
    @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) Color? color,
    String? type,
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
}

List<Map<String, dynamic>> _encodeLatLngList(List<LatLng>? points) => points!
    .map((e) => {'latitude': e.latitude, 'longitude': e.longitude})
    .toList();

List<LatLng> _decodeLatLngList(List<dynamic> points) =>
    points.map((e) => LatLng(e['latitude'], e['longitude'])).toList();

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
