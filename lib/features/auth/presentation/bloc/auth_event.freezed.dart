// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckAuthStatusEvent value)?  checkAuthStatus,TResult Function( LoginEvent value)?  login,TResult Function( LogoutEvent value)?  logout,TResult Function( UpdateUserEvent value)?  updateUser,TResult Function( SessionExpiredEvent value)?  sessionExpired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus(_that);case LoginEvent() when login != null:
return login(_that);case LogoutEvent() when logout != null:
return logout(_that);case UpdateUserEvent() when updateUser != null:
return updateUser(_that);case SessionExpiredEvent() when sessionExpired != null:
return sessionExpired(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckAuthStatusEvent value)  checkAuthStatus,required TResult Function( LoginEvent value)  login,required TResult Function( LogoutEvent value)  logout,required TResult Function( UpdateUserEvent value)  updateUser,required TResult Function( SessionExpiredEvent value)  sessionExpired,}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent():
return checkAuthStatus(_that);case LoginEvent():
return login(_that);case LogoutEvent():
return logout(_that);case UpdateUserEvent():
return updateUser(_that);case SessionExpiredEvent():
return sessionExpired(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckAuthStatusEvent value)?  checkAuthStatus,TResult? Function( LoginEvent value)?  login,TResult? Function( LogoutEvent value)?  logout,TResult? Function( UpdateUserEvent value)?  updateUser,TResult? Function( SessionExpiredEvent value)?  sessionExpired,}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus(_that);case LoginEvent() when login != null:
return login(_that);case LogoutEvent() when logout != null:
return logout(_that);case UpdateUserEvent() when updateUser != null:
return updateUser(_that);case SessionExpiredEvent() when sessionExpired != null:
return sessionExpired(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkAuthStatus,TResult Function( String username,  String password)?  login,TResult Function()?  logout,TResult Function( User user)?  updateUser,TResult Function()?  sessionExpired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus();case LoginEvent() when login != null:
return login(_that.username,_that.password);case LogoutEvent() when logout != null:
return logout();case UpdateUserEvent() when updateUser != null:
return updateUser(_that.user);case SessionExpiredEvent() when sessionExpired != null:
return sessionExpired();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkAuthStatus,required TResult Function( String username,  String password)  login,required TResult Function()  logout,required TResult Function( User user)  updateUser,required TResult Function()  sessionExpired,}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent():
return checkAuthStatus();case LoginEvent():
return login(_that.username,_that.password);case LogoutEvent():
return logout();case UpdateUserEvent():
return updateUser(_that.user);case SessionExpiredEvent():
return sessionExpired();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkAuthStatus,TResult? Function( String username,  String password)?  login,TResult? Function()?  logout,TResult? Function( User user)?  updateUser,TResult? Function()?  sessionExpired,}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus();case LoginEvent() when login != null:
return login(_that.username,_that.password);case LogoutEvent() when logout != null:
return logout();case UpdateUserEvent() when updateUser != null:
return updateUser(_that.user);case SessionExpiredEvent() when sessionExpired != null:
return sessionExpired();case _:
  return null;

}
}

}

/// @nodoc


class CheckAuthStatusEvent implements AuthEvent {
  const CheckAuthStatusEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckAuthStatusEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class LoginEvent implements AuthEvent {
  const LoginEvent({required this.username, required this.password});
  

 final  String username;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEventCopyWith<LoginEvent> get copyWith => _$LoginEventCopyWithImpl<LoginEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthEvent.login(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $LoginEventCopyWith(LoginEvent value, $Res Function(LoginEvent) _then) = _$LoginEventCopyWithImpl;
@useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class _$LoginEventCopyWithImpl<$Res>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._self, this._then);

  final LoginEvent _self;
  final $Res Function(LoginEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(LoginEvent(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogoutEvent implements AuthEvent {
  const LogoutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logout()';
}


}




/// @nodoc


class UpdateUserEvent implements AuthEvent {
  const UpdateUserEvent({required this.user});
  

 final  User user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserEventCopyWith<UpdateUserEvent> get copyWith => _$UpdateUserEventCopyWithImpl<UpdateUserEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserEvent&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.updateUser(user: $user)';
}


}

/// @nodoc
abstract mixin class $UpdateUserEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $UpdateUserEventCopyWith(UpdateUserEvent value, $Res Function(UpdateUserEvent) _then) = _$UpdateUserEventCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$UpdateUserEventCopyWithImpl<$Res>
    implements $UpdateUserEventCopyWith<$Res> {
  _$UpdateUserEventCopyWithImpl(this._self, this._then);

  final UpdateUserEvent _self;
  final $Res Function(UpdateUserEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(UpdateUserEvent(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class SessionExpiredEvent implements AuthEvent {
  const SessionExpiredEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionExpiredEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.sessionExpired()';
}


}




// dart format on
