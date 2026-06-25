// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CustomerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomerEvent()';
  }
}

/// @nodoc
class $CustomerEventCopyWith<$Res> {
  $CustomerEventCopyWith(CustomerEvent _, $Res Function(CustomerEvent) __);
}

/// Adds pattern-matching-related methods to [CustomerEvent].
extension CustomerEventPatterns on CustomerEvent {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCustomersEvent value)? loadCustomers,
    TResult Function(LoadLedgerEvent value)? loadLedger,
    TResult Function(CreateCustomerEvent value)? createCustomer,
    TResult Function(RecordPaymentEvent value)? recordPayment,
    TResult Function(ClearMessagesEvent value)? clearMessages,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent() when loadCustomers != null:
        return loadCustomers(_that);
      case LoadLedgerEvent() when loadLedger != null:
        return loadLedger(_that);
      case CreateCustomerEvent() when createCustomer != null:
        return createCustomer(_that);
      case RecordPaymentEvent() when recordPayment != null:
        return recordPayment(_that);
      case ClearMessagesEvent() when clearMessages != null:
        return clearMessages(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCustomersEvent value) loadCustomers,
    required TResult Function(LoadLedgerEvent value) loadLedger,
    required TResult Function(CreateCustomerEvent value) createCustomer,
    required TResult Function(RecordPaymentEvent value) recordPayment,
    required TResult Function(ClearMessagesEvent value) clearMessages,
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent():
        return loadCustomers(_that);
      case LoadLedgerEvent():
        return loadLedger(_that);
      case CreateCustomerEvent():
        return createCustomer(_that);
      case RecordPaymentEvent():
        return recordPayment(_that);
      case ClearMessagesEvent():
        return clearMessages(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCustomersEvent value)? loadCustomers,
    TResult? Function(LoadLedgerEvent value)? loadLedger,
    TResult? Function(CreateCustomerEvent value)? createCustomer,
    TResult? Function(RecordPaymentEvent value)? recordPayment,
    TResult? Function(ClearMessagesEvent value)? clearMessages,
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent() when loadCustomers != null:
        return loadCustomers(_that);
      case LoadLedgerEvent() when loadLedger != null:
        return loadLedger(_that);
      case CreateCustomerEvent() when createCustomer != null:
        return createCustomer(_that);
      case RecordPaymentEvent() when recordPayment != null:
        return recordPayment(_that);
      case ClearMessagesEvent() when clearMessages != null:
        return clearMessages(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCustomers,
    TResult Function(String customerId)? loadLedger,
    TResult Function(String name, String phone, String? email, String? address)?
        createCustomer,
    TResult Function(
            String customerId, double amount, String paymentMode, String? note)?
        recordPayment,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent() when loadCustomers != null:
        return loadCustomers();
      case LoadLedgerEvent() when loadLedger != null:
        return loadLedger(_that.customerId);
      case CreateCustomerEvent() when createCustomer != null:
        return createCustomer(
            _that.name, _that.phone, _that.email, _that.address);
      case RecordPaymentEvent() when recordPayment != null:
        return recordPayment(
            _that.customerId, _that.amount, _that.paymentMode, _that.note);
      case ClearMessagesEvent() when clearMessages != null:
        return clearMessages();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCustomers,
    required TResult Function(String customerId) loadLedger,
    required TResult Function(
            String name, String phone, String? email, String? address)
        createCustomer,
    required TResult Function(
            String customerId, double amount, String paymentMode, String? note)
        recordPayment,
    required TResult Function() clearMessages,
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent():
        return loadCustomers();
      case LoadLedgerEvent():
        return loadLedger(_that.customerId);
      case CreateCustomerEvent():
        return createCustomer(
            _that.name, _that.phone, _that.email, _that.address);
      case RecordPaymentEvent():
        return recordPayment(
            _that.customerId, _that.amount, _that.paymentMode, _that.note);
      case ClearMessagesEvent():
        return clearMessages();
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCustomers,
    TResult? Function(String customerId)? loadLedger,
    TResult? Function(
            String name, String phone, String? email, String? address)?
        createCustomer,
    TResult? Function(
            String customerId, double amount, String paymentMode, String? note)?
        recordPayment,
    TResult? Function()? clearMessages,
  }) {
    final _that = this;
    switch (_that) {
      case LoadCustomersEvent() when loadCustomers != null:
        return loadCustomers();
      case LoadLedgerEvent() when loadLedger != null:
        return loadLedger(_that.customerId);
      case CreateCustomerEvent() when createCustomer != null:
        return createCustomer(
            _that.name, _that.phone, _that.email, _that.address);
      case RecordPaymentEvent() when recordPayment != null:
        return recordPayment(
            _that.customerId, _that.amount, _that.paymentMode, _that.note);
      case ClearMessagesEvent() when clearMessages != null:
        return clearMessages();
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoadCustomersEvent implements CustomerEvent {
  const LoadCustomersEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadCustomersEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomerEvent.loadCustomers()';
  }
}

/// @nodoc

class LoadLedgerEvent implements CustomerEvent {
  const LoadLedgerEvent({required this.customerId});

  final String customerId;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadLedgerEventCopyWith<LoadLedgerEvent> get copyWith =>
      _$LoadLedgerEventCopyWithImpl<LoadLedgerEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadLedgerEvent &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, customerId);

  @override
  String toString() {
    return 'CustomerEvent.loadLedger(customerId: $customerId)';
  }
}

/// @nodoc
abstract mixin class $LoadLedgerEventCopyWith<$Res>
    implements $CustomerEventCopyWith<$Res> {
  factory $LoadLedgerEventCopyWith(
          LoadLedgerEvent value, $Res Function(LoadLedgerEvent) _then) =
      _$LoadLedgerEventCopyWithImpl;
  @useResult
  $Res call({String customerId});
}

/// @nodoc
class _$LoadLedgerEventCopyWithImpl<$Res>
    implements $LoadLedgerEventCopyWith<$Res> {
  _$LoadLedgerEventCopyWithImpl(this._self, this._then);

  final LoadLedgerEvent _self;
  final $Res Function(LoadLedgerEvent) _then;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? customerId = null,
  }) {
    return _then(LoadLedgerEvent(
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class CreateCustomerEvent implements CustomerEvent {
  const CreateCustomerEvent(
      {required this.name, required this.phone, this.email, this.address});

  final String name;
  final String phone;
  final String? email;
  final String? address;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateCustomerEventCopyWith<CreateCustomerEvent> get copyWith =>
      _$CreateCustomerEventCopyWithImpl<CreateCustomerEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateCustomerEvent &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, phone, email, address);

  @override
  String toString() {
    return 'CustomerEvent.createCustomer(name: $name, phone: $phone, email: $email, address: $address)';
  }
}

/// @nodoc
abstract mixin class $CreateCustomerEventCopyWith<$Res>
    implements $CustomerEventCopyWith<$Res> {
  factory $CreateCustomerEventCopyWith(
          CreateCustomerEvent value, $Res Function(CreateCustomerEvent) _then) =
      _$CreateCustomerEventCopyWithImpl;
  @useResult
  $Res call({String name, String phone, String? email, String? address});
}

/// @nodoc
class _$CreateCustomerEventCopyWithImpl<$Res>
    implements $CreateCustomerEventCopyWith<$Res> {
  _$CreateCustomerEventCopyWithImpl(this._self, this._then);

  final CreateCustomerEvent _self;
  final $Res Function(CreateCustomerEvent) _then;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? email = freezed,
    Object? address = freezed,
  }) {
    return _then(CreateCustomerEvent(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class RecordPaymentEvent implements CustomerEvent {
  const RecordPaymentEvent(
      {required this.customerId,
      required this.amount,
      required this.paymentMode,
      this.note});

  final String customerId;
  final double amount;
  final String paymentMode;
  final String? note;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordPaymentEventCopyWith<RecordPaymentEvent> get copyWith =>
      _$RecordPaymentEventCopyWithImpl<RecordPaymentEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordPaymentEvent &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, customerId, amount, paymentMode, note);

  @override
  String toString() {
    return 'CustomerEvent.recordPayment(customerId: $customerId, amount: $amount, paymentMode: $paymentMode, note: $note)';
  }
}

/// @nodoc
abstract mixin class $RecordPaymentEventCopyWith<$Res>
    implements $CustomerEventCopyWith<$Res> {
  factory $RecordPaymentEventCopyWith(
          RecordPaymentEvent value, $Res Function(RecordPaymentEvent) _then) =
      _$RecordPaymentEventCopyWithImpl;
  @useResult
  $Res call(
      {String customerId, double amount, String paymentMode, String? note});
}

/// @nodoc
class _$RecordPaymentEventCopyWithImpl<$Res>
    implements $RecordPaymentEventCopyWith<$Res> {
  _$RecordPaymentEventCopyWithImpl(this._self, this._then);

  final RecordPaymentEvent _self;
  final $Res Function(RecordPaymentEvent) _then;

  /// Create a copy of CustomerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? customerId = null,
    Object? amount = null,
    Object? paymentMode = null,
    Object? note = freezed,
  }) {
    return _then(RecordPaymentEvent(
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMode: null == paymentMode
          ? _self.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class ClearMessagesEvent implements CustomerEvent {
  const ClearMessagesEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ClearMessagesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomerEvent.clearMessages()';
  }
}

// dart format on
