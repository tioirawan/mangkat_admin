// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fleet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FleetModel _$FleetModelFromJson(Map<String, dynamic> json) {
  return _FleetModel.fromJson(json);
}

/// @nodoc
mixin _$FleetModel {
  String? get id => throw _privateConstructorUsedError;
  String? get vehicleNumber => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  FleetStatus? get status => throw _privateConstructorUsedError;
  FleetType? get type => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_capacity')
  int? get maxCapacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_id')
  String? get driverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_id')
  String? get routeId => throw _privateConstructorUsedError; // timestamp
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FleetModelCopyWith<FleetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FleetModelCopyWith<$Res> {
  factory $FleetModelCopyWith(
          FleetModel value, $Res Function(FleetModel) then) =
      _$FleetModelCopyWithImpl<$Res, FleetModel>;
  @useResult
  $Res call(
      {String? id,
      String? vehicleNumber,
      String? image,
      FleetStatus? status,
      FleetType? type,
      String? notes,
      @JsonKey(name: 'max_capacity') int? maxCapacity,
      @JsonKey(name: 'driver_id') String? driverId,
      @JsonKey(name: 'route_id') String? routeId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$FleetModelCopyWithImpl<$Res, $Val extends FleetModel>
    implements $FleetModelCopyWith<$Res> {
  _$FleetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleNumber = freezed,
    Object? image = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? notes = freezed,
    Object? maxCapacity = freezed,
    Object? driverId = freezed,
    Object? routeId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FleetStatus?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FleetType?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      maxCapacity: freezed == maxCapacity
          ? _value.maxCapacity
          : maxCapacity // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FleetModelImplCopyWith<$Res>
    implements $FleetModelCopyWith<$Res> {
  factory _$$FleetModelImplCopyWith(
          _$FleetModelImpl value, $Res Function(_$FleetModelImpl) then) =
      __$$FleetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? vehicleNumber,
      String? image,
      FleetStatus? status,
      FleetType? type,
      String? notes,
      @JsonKey(name: 'max_capacity') int? maxCapacity,
      @JsonKey(name: 'driver_id') String? driverId,
      @JsonKey(name: 'route_id') String? routeId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$FleetModelImplCopyWithImpl<$Res>
    extends _$FleetModelCopyWithImpl<$Res, _$FleetModelImpl>
    implements _$$FleetModelImplCopyWith<$Res> {
  __$$FleetModelImplCopyWithImpl(
      _$FleetModelImpl _value, $Res Function(_$FleetModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleNumber = freezed,
    Object? image = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? notes = freezed,
    Object? maxCapacity = freezed,
    Object? driverId = freezed,
    Object? routeId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$FleetModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FleetStatus?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FleetType?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      maxCapacity: freezed == maxCapacity
          ? _value.maxCapacity
          : maxCapacity // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
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
class _$FleetModelImpl extends _FleetModel {
  _$FleetModelImpl(
      {this.id,
      this.vehicleNumber,
      this.image,
      this.status,
      this.type,
      this.notes,
      @JsonKey(name: 'max_capacity') this.maxCapacity,
      @JsonKey(name: 'driver_id') this.driverId,
      @JsonKey(name: 'route_id') this.routeId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : super._();

  factory _$FleetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FleetModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? vehicleNumber;
  @override
  final String? image;
  @override
  final FleetStatus? status;
  @override
  final FleetType? type;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'max_capacity')
  final int? maxCapacity;
  @override
  @JsonKey(name: 'driver_id')
  final String? driverId;
  @override
  @JsonKey(name: 'route_id')
  final String? routeId;
// timestamp
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'FleetModel(id: $id, vehicleNumber: $vehicleNumber, image: $image, status: $status, type: $type, notes: $notes, maxCapacity: $maxCapacity, driverId: $driverId, routeId: $routeId, createdAt: $createdAt, updatedAt: $updatedAt, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FleetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicleNumber, vehicleNumber) ||
                other.vehicleNumber == vehicleNumber) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.maxCapacity, maxCapacity) ||
                other.maxCapacity == maxCapacity) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      vehicleNumber,
      image,
      status,
      type,
      notes,
      maxCapacity,
      driverId,
      routeId,
      createdAt,
      updatedAt,
      reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FleetModelImplCopyWith<_$FleetModelImpl> get copyWith =>
      __$$FleetModelImplCopyWithImpl<_$FleetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FleetModelImplToJson(
      this,
    );
  }
}

abstract class _FleetModel extends FleetModel {
  factory _FleetModel(
      {final String? id,
      final String? vehicleNumber,
      final String? image,
      final FleetStatus? status,
      final FleetType? type,
      final String? notes,
      @JsonKey(name: 'max_capacity') final int? maxCapacity,
      @JsonKey(name: 'driver_id') final String? driverId,
      @JsonKey(name: 'route_id') final String? routeId,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$FleetModelImpl;
  _FleetModel._() : super._();

  factory _FleetModel.fromJson(Map<String, dynamic> json) =
      _$FleetModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get vehicleNumber;
  @override
  String? get image;
  @override
  FleetStatus? get status;
  @override
  FleetType? get type;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'max_capacity')
  int? get maxCapacity;
  @override
  @JsonKey(name: 'driver_id')
  String? get driverId;
  @override
  @JsonKey(name: 'route_id')
  String? get routeId;
  @override // timestamp
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$FleetModelImplCopyWith<_$FleetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
