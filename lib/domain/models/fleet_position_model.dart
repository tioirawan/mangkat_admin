// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fleet_position_model.freezed.dart';
part 'fleet_position_model.g.dart';

@freezed
class FleetPositionModel with _$FleetPositionModel {
  const FleetPositionModel._();

  factory FleetPositionModel({
    double? latitude,
    double? longitude,
    double? heading,
    double? speed,
    double? odometer,
    @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
    DateTime? timestamp,
  }) = _FleetPositionModel;

  factory FleetPositionModel.fromJson(Map<String, dynamic> json) =>
      _$FleetPositionModelFromJson(json);
}

int _encodeTimestamp(DateTime? timestamp) {
  if (timestamp == null) {
    return 0;
  }

  return timestamp.millisecondsSinceEpoch;
}

DateTime? _decodeTimestamp(int? timestamp) {
  if (timestamp == null) {
    return null;
  }

  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}
