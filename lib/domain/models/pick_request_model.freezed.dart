// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PickRequestModel _$PickRequestModelFromJson(Map<String, dynamic> json) {
  return _PickRequestModel.fromJson(json);
}

/// @nodoc
mixin _$PickRequestModel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_id')
  String? get routeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'fleet_id')
  String? get fleetId => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool? get picked => throw _privateConstructorUsedError;
  @JsonKey(name: 'picked_at')
  DateTime? get pickedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PickRequestModelCopyWith<PickRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickRequestModelCopyWith<$Res> {
  factory $PickRequestModelCopyWith(
          PickRequestModel value, $Res Function(PickRequestModel) then) =
      _$PickRequestModelCopyWithImpl<$Res, PickRequestModel>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'route_id') String? routeId,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'fleet_id') String? fleetId,
      double? latitude,
      double? longitude,
      bool? picked,
      @JsonKey(name: 'picked_at') DateTime? pickedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$PickRequestModelCopyWithImpl<$Res, $Val extends PickRequestModel>
    implements $PickRequestModelCopyWith<$Res> {
  _$PickRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? routeId = freezed,
    Object? userId = freezed,
    Object? fleetId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? picked = freezed,
    Object? pickedAt = freezed,
    Object? createdAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      fleetId: freezed == fleetId
          ? _value.fleetId
          : fleetId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      picked: freezed == picked
          ? _value.picked
          : picked // ignore: cast_nullable_to_non_nullable
              as bool?,
      pickedAt: freezed == pickedAt
          ? _value.pickedAt
          : pickedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PickRequestModelImplCopyWith<$Res>
    implements $PickRequestModelCopyWith<$Res> {
  factory _$$PickRequestModelImplCopyWith(_$PickRequestModelImpl value,
          $Res Function(_$PickRequestModelImpl) then) =
      __$$PickRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'route_id') String? routeId,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'fleet_id') String? fleetId,
      double? latitude,
      double? longitude,
      bool? picked,
      @JsonKey(name: 'picked_at') DateTime? pickedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$PickRequestModelImplCopyWithImpl<$Res>
    extends _$PickRequestModelCopyWithImpl<$Res, _$PickRequestModelImpl>
    implements _$$PickRequestModelImplCopyWith<$Res> {
  __$$PickRequestModelImplCopyWithImpl(_$PickRequestModelImpl _value,
      $Res Function(_$PickRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? routeId = freezed,
    Object? userId = freezed,
    Object? fleetId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? picked = freezed,
    Object? pickedAt = freezed,
    Object? createdAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$PickRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      fleetId: freezed == fleetId
          ? _value.fleetId
          : fleetId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      picked: freezed == picked
          ? _value.picked
          : picked // ignore: cast_nullable_to_non_nullable
              as bool?,
      pickedAt: freezed == pickedAt
          ? _value.pickedAt
          : pickedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PickRequestModelImpl extends _PickRequestModel {
  _$PickRequestModelImpl(
      {this.id,
      @JsonKey(name: 'route_id') this.routeId,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'fleet_id') this.fleetId,
      this.latitude,
      this.longitude,
      this.picked = false,
      @JsonKey(name: 'picked_at') this.pickedAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : super._();

  factory _$PickRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickRequestModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'route_id')
  final String? routeId;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'fleet_id')
  final String? fleetId;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final bool? picked;
  @override
  @JsonKey(name: 'picked_at')
  final DateTime? pickedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'PickRequestModel(id: $id, routeId: $routeId, userId: $userId, fleetId: $fleetId, latitude: $latitude, longitude: $longitude, picked: $picked, pickedAt: $pickedAt, createdAt: $createdAt, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fleetId, fleetId) || other.fleetId == fleetId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.picked, picked) || other.picked == picked) &&
            (identical(other.pickedAt, pickedAt) ||
                other.pickedAt == pickedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, routeId, userId, fleetId,
      latitude, longitude, picked, pickedAt, createdAt, reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickRequestModelImplCopyWith<_$PickRequestModelImpl> get copyWith =>
      __$$PickRequestModelImplCopyWithImpl<_$PickRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickRequestModelImplToJson(
      this,
    );
  }
}

abstract class _PickRequestModel extends PickRequestModel {
  factory _PickRequestModel(
      {final String? id,
      @JsonKey(name: 'route_id') final String? routeId,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'fleet_id') final String? fleetId,
      final double? latitude,
      final double? longitude,
      final bool? picked,
      @JsonKey(name: 'picked_at') final DateTime? pickedAt,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$PickRequestModelImpl;
  _PickRequestModel._() : super._();

  factory _PickRequestModel.fromJson(Map<String, dynamic> json) =
      _$PickRequestModelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'route_id')
  String? get routeId;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'fleet_id')
  String? get fleetId;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  bool? get picked;
  @override
  @JsonKey(name: 'picked_at')
  DateTime? get pickedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$PickRequestModelImplCopyWith<_$PickRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
