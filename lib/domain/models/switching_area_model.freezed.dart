// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'switching_area_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwitchingAreaModel _$SwitchingAreaModelFromJson(Map<String, dynamic> json) {
  return _SwitchingArea.fromJson(json);
}

/// @nodoc
mixin _$SwitchingAreaModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get radius => throw _privateConstructorUsedError;

  /// trayek trayek yang dapat dilayani oleh area ini
  List<String>? get routes => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwitchingAreaModelCopyWith<SwitchingAreaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwitchingAreaModelCopyWith<$Res> {
  factory $SwitchingAreaModelCopyWith(
          SwitchingAreaModel value, $Res Function(SwitchingAreaModel) then) =
      _$SwitchingAreaModelCopyWithImpl<$Res, SwitchingAreaModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      double? latitude,
      double? longitude,
      double? radius,
      List<String>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$SwitchingAreaModelCopyWithImpl<$Res, $Val extends SwitchingAreaModel>
    implements $SwitchingAreaModelCopyWith<$Res> {
  _$SwitchingAreaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radius = freezed,
    Object? routes = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      routes: freezed == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwitchingAreaImplCopyWith<$Res>
    implements $SwitchingAreaModelCopyWith<$Res> {
  factory _$$SwitchingAreaImplCopyWith(
          _$SwitchingAreaImpl value, $Res Function(_$SwitchingAreaImpl) then) =
      __$$SwitchingAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      double? latitude,
      double? longitude,
      double? radius,
      List<String>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$SwitchingAreaImplCopyWithImpl<$Res>
    extends _$SwitchingAreaModelCopyWithImpl<$Res, _$SwitchingAreaImpl>
    implements _$$SwitchingAreaImplCopyWith<$Res> {
  __$$SwitchingAreaImplCopyWithImpl(
      _$SwitchingAreaImpl _value, $Res Function(_$SwitchingAreaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radius = freezed,
    Object? routes = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$SwitchingAreaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      routes: freezed == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwitchingAreaImpl extends _SwitchingArea {
  _$SwitchingAreaImpl(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.radius,
      final List<String>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : _routes = routes,
        super._();

  factory _$SwitchingAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwitchingAreaImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? radius;

  /// trayek trayek yang dapat dilayani oleh area ini
  final List<String>? _routes;

  /// trayek trayek yang dapat dilayani oleh area ini
  @override
  List<String>? get routes {
    final value = _routes;
    if (value == null) return null;
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'SwitchingAreaModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, radius: $radius, routes: $routes, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwitchingAreaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, latitude, longitude,
      radius, const DeepCollectionEquality().hash(_routes), reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwitchingAreaImplCopyWith<_$SwitchingAreaImpl> get copyWith =>
      __$$SwitchingAreaImplCopyWithImpl<_$SwitchingAreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwitchingAreaImplToJson(
      this,
    );
  }
}

abstract class _SwitchingArea extends SwitchingAreaModel {
  factory _SwitchingArea(
      {final String? id,
      final String? name,
      final double? latitude,
      final double? longitude,
      final double? radius,
      final List<String>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$SwitchingAreaImpl;
  _SwitchingArea._() : super._();

  factory _SwitchingArea.fromJson(Map<String, dynamic> json) =
      _$SwitchingAreaImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get radius;
  @override

  /// trayek trayek yang dapat dilayani oleh area ini
  List<String>? get routes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$SwitchingAreaImplCopyWith<_$SwitchingAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
