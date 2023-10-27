// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fleet_model.freezed.dart';
part 'fleet_model.g.dart';

enum FleetStatus {
  @JsonValue('idle')
  idle,
  @JsonValue('operating')
  operating,
  @JsonValue('rented')
  rented,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('broken')
  broken,
  @JsonValue('unknown')
  unknown,
}

enum FleetType {
  @JsonValue('mini_bus')
  miniBus,
  @JsonValue('medium_bus')
  mediumBus,
  @JsonValue('big_bus')
  bigBus,
  @JsonValue('other')
  other,
}

extension FleetStatusX on FleetStatus {
  String get name {
    switch (this) {
      case FleetStatus.idle:
        return 'Idle';
      case FleetStatus.operating:
        return 'Operating';
      case FleetStatus.rented:
        return 'Rented';
      case FleetStatus.maintenance:
        return 'Maintenance';
      case FleetStatus.broken:
        return 'Broken';
      case FleetStatus.unknown:
        return 'Unknown';
    }
  }
}

extension FleetTypeX on FleetType {
  String get name {
    switch (this) {
      case FleetType.miniBus:
        return 'Mini Bus';
      case FleetType.mediumBus:
        return 'Medium Bus';
      case FleetType.bigBus:
        return 'Big Bus';
      case FleetType.other:
        return 'Other';
    }
  }
}

@freezed
class FleetModel with _$FleetModel {
  const FleetModel._();

  factory FleetModel({
    String? id,
    String? vehicleNumber,
    String? image,
    FleetStatus? status,
    FleetType? type,
    String? notes,
    String? driverRef,
    String? routeRef,
    // timestamp
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference? reference,
  }) = _FleetModel;

  factory FleetModel.fromJson(Map<String, dynamic> json) =>
      _$FleetModelFromJson(json);

  factory FleetModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return FleetModel.fromJson(data).copyWith(
      id: snapshot.id,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toDocument() => toJson()
    ..remove('id')
    ..remove('reference');
}
