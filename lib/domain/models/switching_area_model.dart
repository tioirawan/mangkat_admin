// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'switching_area_model.freezed.dart';
part 'switching_area_model.g.dart';

@freezed
class SwitchingAreaModel with _$SwitchingAreaModel {
  const SwitchingAreaModel._();

  factory SwitchingAreaModel({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    double? radius,

    /// trayek trayek yang dapat dilayani oleh area ini
    List<String>? routes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference? reference,
  }) = _SwitchingArea;

  factory SwitchingAreaModel.fromJson(Map<String, dynamic> json) =>
      _$SwitchingAreaModelFromJson(json);

  factory SwitchingAreaModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return SwitchingAreaModel.fromJson(data).copyWith(
      id: snapshot.id,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toDocument() => toJson()
    ..remove('id')
    ..remove('reference');
}
