// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) {
  return _Route.fromJson(json);
}

/// @nodoc
mixin _$RouteModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'start_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  TimeOfDay? get startOperation => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'end_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  TimeOfDay? get endOperation => throw _privateConstructorUsedError;
  @JsonKey(toJson: _encodeColor, fromJson: _decodeColor)
  Color? get color => throw _privateConstructorUsedError;
  RouteType? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get checkpoints => throw _privateConstructorUsedError;
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get routes => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteModelCopyWith<RouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
          RouteModel value, $Res Function(RouteModel) then) =
      _$RouteModelCopyWithImpl<$Res, RouteModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      @JsonKey(
          name: 'start_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      TimeOfDay? startOperation,
      @JsonKey(
          name: 'end_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      TimeOfDay? endOperation,
      @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) Color? color,
      RouteType? type,
      String? description,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      List<LatLng>? checkpoints,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      List<LatLng>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res, $Val extends RouteModel>
    implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? startOperation = freezed,
    Object? endOperation = freezed,
    Object? color = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? checkpoints = freezed,
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
      startOperation: freezed == startOperation
          ? _value.startOperation
          : startOperation // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      endOperation: freezed == endOperation
          ? _value.endOperation
          : endOperation // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RouteType?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      checkpoints: freezed == checkpoints
          ? _value.checkpoints
          : checkpoints // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      routes: freezed == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteImplCopyWith<$Res> implements $RouteModelCopyWith<$Res> {
  factory _$$RouteImplCopyWith(
          _$RouteImpl value, $Res Function(_$RouteImpl) then) =
      __$$RouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      @JsonKey(
          name: 'start_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      TimeOfDay? startOperation,
      @JsonKey(
          name: 'end_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      TimeOfDay? endOperation,
      @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) Color? color,
      RouteType? type,
      String? description,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      List<LatLng>? checkpoints,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      List<LatLng>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$RouteImplCopyWithImpl<$Res>
    extends _$RouteModelCopyWithImpl<$Res, _$RouteImpl>
    implements _$$RouteImplCopyWith<$Res> {
  __$$RouteImplCopyWithImpl(
      _$RouteImpl _value, $Res Function(_$RouteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? startOperation = freezed,
    Object? endOperation = freezed,
    Object? color = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? checkpoints = freezed,
    Object? routes = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$RouteImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      startOperation: freezed == startOperation
          ? _value.startOperation
          : startOperation // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      endOperation: freezed == endOperation
          ? _value.endOperation
          : endOperation // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RouteType?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      checkpoints: freezed == checkpoints
          ? _value._checkpoints
          : checkpoints // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      routes: freezed == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteImpl extends _Route {
  const _$RouteImpl(
      {this.id,
      this.name,
      @JsonKey(
          name: 'start_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      this.startOperation,
      @JsonKey(
          name: 'end_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      this.endOperation,
      @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) this.color,
      this.type,
      this.description,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      final List<LatLng>? checkpoints,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      final List<LatLng>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : _checkpoints = checkpoints,
        _routes = routes,
        super._();

  factory _$RouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  @JsonKey(
      name: 'start_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  final TimeOfDay? startOperation;
  @override
  @JsonKey(
      name: 'end_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  final TimeOfDay? endOperation;
  @override
  @JsonKey(toJson: _encodeColor, fromJson: _decodeColor)
  final Color? color;
  @override
  final RouteType? type;
  @override
  final String? description;
  final List<LatLng>? _checkpoints;
  @override
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get checkpoints {
    final value = _checkpoints;
    if (value == null) return null;
    if (_checkpoints is EqualUnmodifiableListView) return _checkpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LatLng>? _routes;
  @override
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get routes {
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
    return 'RouteModel(id: $id, name: $name, startOperation: $startOperation, endOperation: $endOperation, color: $color, type: $type, description: $description, checkpoints: $checkpoints, routes: $routes, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startOperation, startOperation) ||
                other.startOperation == startOperation) &&
            (identical(other.endOperation, endOperation) ||
                other.endOperation == endOperation) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._checkpoints, _checkpoints) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      startOperation,
      endOperation,
      color,
      type,
      description,
      const DeepCollectionEquality().hash(_checkpoints),
      const DeepCollectionEquality().hash(_routes),
      reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      __$$RouteImplCopyWithImpl<_$RouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteImplToJson(
      this,
    );
  }
}

abstract class _Route extends RouteModel {
  const factory _Route(
      {final String? id,
      final String? name,
      @JsonKey(
          name: 'start_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      final TimeOfDay? startOperation,
      @JsonKey(
          name: 'end_operation',
          toJson: _encodeTimeOfDay,
          fromJson: _decodeTimeOfDay)
      final TimeOfDay? endOperation,
      @JsonKey(toJson: _encodeColor, fromJson: _decodeColor) final Color? color,
      final RouteType? type,
      final String? description,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      final List<LatLng>? checkpoints,
      @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
      final List<LatLng>? routes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$RouteImpl;
  const _Route._() : super._();

  factory _Route.fromJson(Map<String, dynamic> json) = _$RouteImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(
      name: 'start_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  TimeOfDay? get startOperation;
  @override
  @JsonKey(
      name: 'end_operation',
      toJson: _encodeTimeOfDay,
      fromJson: _decodeTimeOfDay)
  TimeOfDay? get endOperation;
  @override
  @JsonKey(toJson: _encodeColor, fromJson: _decodeColor)
  Color? get color;
  @override
  RouteType? get type;
  @override
  String? get description;
  @override
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get checkpoints;
  @override
  @JsonKey(toJson: _encodeLatLngList, fromJson: _decodeLatLngList)
  List<LatLng>? get routes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
