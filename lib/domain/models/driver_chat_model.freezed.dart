// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DriverChatModel _$DriverChatModelFromJson(Map<String, dynamic> json) {
  return _DriverChatModel.fromJson(json);
}

/// @nodoc
mixin _$DriverChatModel {
  String? get id => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverChatModelCopyWith<DriverChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverChatModelCopyWith<$Res> {
  factory $DriverChatModelCopyWith(
          DriverChatModel value, $Res Function(DriverChatModel) then) =
      _$DriverChatModelCopyWithImpl<$Res, DriverChatModel>;
  @useResult
  $Res call(
      {String? id,
      String? message,
      @JsonKey(name: 'sender_id') String? senderId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$DriverChatModelCopyWithImpl<$Res, $Val extends DriverChatModel>
    implements $DriverChatModelCopyWith<$Res> {
  _$DriverChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? message = freezed,
    Object? senderId = freezed,
    Object? createdAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$DriverChatModelImplCopyWith<$Res>
    implements $DriverChatModelCopyWith<$Res> {
  factory _$$DriverChatModelImplCopyWith(_$DriverChatModelImpl value,
          $Res Function(_$DriverChatModelImpl) then) =
      __$$DriverChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? message,
      @JsonKey(name: 'sender_id') String? senderId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$DriverChatModelImplCopyWithImpl<$Res>
    extends _$DriverChatModelCopyWithImpl<$Res, _$DriverChatModelImpl>
    implements _$$DriverChatModelImplCopyWith<$Res> {
  __$$DriverChatModelImplCopyWithImpl(
      _$DriverChatModelImpl _value, $Res Function(_$DriverChatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? message = freezed,
    Object? senderId = freezed,
    Object? createdAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$DriverChatModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$DriverChatModelImpl extends _DriverChatModel {
  _$DriverChatModelImpl(
      {this.id,
      this.message,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : super._();

  factory _$DriverChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverChatModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? message;
  @override
  @JsonKey(name: 'sender_id')
  final String? senderId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'DriverChatModel(id: $id, message: $message, senderId: $senderId, createdAt: $createdAt, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverChatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, message, senderId, createdAt, reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverChatModelImplCopyWith<_$DriverChatModelImpl> get copyWith =>
      __$$DriverChatModelImplCopyWithImpl<_$DriverChatModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverChatModelImplToJson(
      this,
    );
  }
}

abstract class _DriverChatModel extends DriverChatModel {
  factory _DriverChatModel(
      {final String? id,
      final String? message,
      @JsonKey(name: 'sender_id') final String? senderId,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$DriverChatModelImpl;
  _DriverChatModel._() : super._();

  factory _DriverChatModel.fromJson(Map<String, dynamic> json) =
      _$DriverChatModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get message;
  @override
  @JsonKey(name: 'sender_id')
  String? get senderId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$DriverChatModelImplCopyWith<_$DriverChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
