// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pick_request_model.freezed.dart';
part 'pick_request_model.g.dart';

@freezed
class PickRequestModel with _$PickRequestModel {
  const PickRequestModel._();

  factory PickRequestModel({
    String? id,
    @JsonKey(name: 'route_id') String? routeId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'fleet_id') String? fleetId,
    double? latitude,
    double? longitude,
    @Default(false) bool? picked,
    @JsonKey(name: 'picked_at') DateTime? pickedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference? reference,
  }) = _PickRequestModel;

  factory PickRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PickRequestModelFromJson(json);

  factory PickRequestModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return PickRequestModel.fromJson(data).copyWith(
      id: snapshot.id,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toDocument() => toJson()
    ..remove('id')
    ..remove('reference');
}
