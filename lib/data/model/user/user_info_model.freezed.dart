// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// part of 'user_info_model.dart';

// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

// UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
//   return _UserInfo.fromJson(json);
// }

// /// @nodoc
// mixin _$UserInfo {
//   String get uuid => throw _privateConstructorUsedError;
//   String get created_at => throw _privateConstructorUsedError;
//   String get username => throw _privateConstructorUsedError;

//   Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
//   @JsonKey(ignore: true)
//   $UserInfoCopyWith<UserInfo> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $UserInfoCopyWith<$Res> {
//   factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
//       _$UserInfoCopyWithImpl<$Res, UserInfo>;
//   @useResult
//   $Res call({String uuid, String created_at, String username});
// }

// /// @nodoc
// class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
//     implements $UserInfoCopyWith<$Res> {
//   _$UserInfoCopyWithImpl(this._value, this._then);

//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? uuid = null,
//     Object? created_at = null,
//     Object? username = null,
//   }) {
//     return _then(_value.copyWith(
//       uuid: null == uuid
//           ? _value.uuid
//           : uuid // ignore: cast_nullable_to_non_nullable
//               as String,
//       created_at: null == created_at
//           ? _value.created_at
//           : created_at // ignore: cast_nullable_to_non_nullable
//               as String,
//       username: null == username
//           ? _value.username
//           : username // ignore: cast_nullable_to_non_nullable
//               as String,
//     ) as $Val);
//   }
// }

// /// @nodoc
// abstract class _$$UserInfoImplCopyWith<$Res>
//     implements $UserInfoCopyWith<$Res> {
//   factory _$$UserInfoImplCopyWith(
//           _$UserInfoImpl value, $Res Function(_$UserInfoImpl) then) =
//       __$$UserInfoImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({String uuid, String created_at, String username});
// }

// /// @nodoc
// class __$$UserInfoImplCopyWithImpl<$Res>
//     extends _$UserInfoCopyWithImpl<$Res, _$UserInfoImpl>
//     implements _$$UserInfoImplCopyWith<$Res> {
//   __$$UserInfoImplCopyWithImpl(
//       _$UserInfoImpl _value, $Res Function(_$UserInfoImpl) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? uuid = null,
//     Object? created_at = null,
//     Object? username = null,
//   }) {
//     return _then(_$UserInfoImpl(
//       uuid: null == uuid
//           ? _value.uuid
//           : uuid // ignore: cast_nullable_to_non_nullable
//               as String,
//       created_at: null == created_at
//           ? _value.created_at
//           : created_at // ignore: cast_nullable_to_non_nullable
//               as String,
//       username: null == username
//           ? _value.username
//           : username // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc
// @JsonSerializable()
// class _$UserInfoImpl implements _UserInfo {
//   const _$UserInfoImpl(
//       {required this.uuid, required this.created_at, required this.username});

//   factory _$UserInfoImpl.fromJson(Map<String, dynamic> json) =>
//       _$$UserInfoImplFromJson(json);

//   @override
//   final String uuid;
//   @override
//   final String created_at;
//   @override
//   final String username;

//   @override
//   String toString() {
//     return 'UserInfo(uuid: $uuid, created_at: $created_at, username: $username)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$UserInfoImpl &&
//             (identical(other.uuid, uuid) || other.uuid == uuid) &&
//             (identical(other.created_at, created_at) ||
//                 other.created_at == created_at) &&
//             (identical(other.username, username) ||
//                 other.username == username));
//   }

//   @JsonKey(ignore: true)
//   @override
//   int get hashCode => Object.hash(runtimeType, uuid, created_at, username);

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
//       __$$UserInfoImplCopyWithImpl<_$UserInfoImpl>(this, _$identity);

//   @override
//   Map<String, dynamic> toJson() {
//     return _$$UserInfoImplToJson(
//       this,
//     );
//   }
// }

// abstract class _UserInfo implements UserInfo {
//   const factory _UserInfo(
//       {required final String uuid,
//       required final String created_at,
//       required final String username}) = _$UserInfoImpl;

//   factory _UserInfo.fromJson(Map<String, dynamic> json) =
//       _$UserInfoImpl.fromJson;

//   @override
//   String get uuid;
//   @override
//   String get created_at;
//   @override
//   String get username;
//   @override
//   @JsonKey(ignore: true)
//   _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }
