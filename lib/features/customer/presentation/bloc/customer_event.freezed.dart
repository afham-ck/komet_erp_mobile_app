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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerEvent()';
}


}

/// @nodoc
class $CustomerEventCopyWith<$Res>  {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadCustomersEvent value)?  loadCustomers,TResult Function( SearchCustomersEvent value)?  searchCustomers,TResult Function( SelectCustomerEvent value)?  selectCustomer,TResult Function( LoadEnrollmentsEvent value)?  loadEnrollments,TResult Function( SelectEnrollmentEvent value)?  selectEnrollment,TResult Function( LoadLedgerEvent value)?  loadLedger,TResult Function( CreateCustomerEvent value)?  createCustomer,TResult Function( SubmitCollectPaymentEvent value)?  submitCollectPayment,TResult Function( RecordPaymentEvent value)?  recordPayment,TResult Function( ClearMessagesEvent value)?  clearMessages,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadCustomersEvent() when loadCustomers != null:
return loadCustomers(_that);case SearchCustomersEvent() when searchCustomers != null:
return searchCustomers(_that);case SelectCustomerEvent() when selectCustomer != null:
return selectCustomer(_that);case LoadEnrollmentsEvent() when loadEnrollments != null:
return loadEnrollments(_that);case SelectEnrollmentEvent() when selectEnrollment != null:
return selectEnrollment(_that);case LoadLedgerEvent() when loadLedger != null:
return loadLedger(_that);case CreateCustomerEvent() when createCustomer != null:
return createCustomer(_that);case SubmitCollectPaymentEvent() when submitCollectPayment != null:
return submitCollectPayment(_that);case RecordPaymentEvent() when recordPayment != null:
return recordPayment(_that);case ClearMessagesEvent() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadCustomersEvent value)  loadCustomers,required TResult Function( SearchCustomersEvent value)  searchCustomers,required TResult Function( SelectCustomerEvent value)  selectCustomer,required TResult Function( LoadEnrollmentsEvent value)  loadEnrollments,required TResult Function( SelectEnrollmentEvent value)  selectEnrollment,required TResult Function( LoadLedgerEvent value)  loadLedger,required TResult Function( CreateCustomerEvent value)  createCustomer,required TResult Function( SubmitCollectPaymentEvent value)  submitCollectPayment,required TResult Function( RecordPaymentEvent value)  recordPayment,required TResult Function( ClearMessagesEvent value)  clearMessages,}){
final _that = this;
switch (_that) {
case LoadCustomersEvent():
return loadCustomers(_that);case SearchCustomersEvent():
return searchCustomers(_that);case SelectCustomerEvent():
return selectCustomer(_that);case LoadEnrollmentsEvent():
return loadEnrollments(_that);case SelectEnrollmentEvent():
return selectEnrollment(_that);case LoadLedgerEvent():
return loadLedger(_that);case CreateCustomerEvent():
return createCustomer(_that);case SubmitCollectPaymentEvent():
return submitCollectPayment(_that);case RecordPaymentEvent():
return recordPayment(_that);case ClearMessagesEvent():
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadCustomersEvent value)?  loadCustomers,TResult? Function( SearchCustomersEvent value)?  searchCustomers,TResult? Function( SelectCustomerEvent value)?  selectCustomer,TResult? Function( LoadEnrollmentsEvent value)?  loadEnrollments,TResult? Function( SelectEnrollmentEvent value)?  selectEnrollment,TResult? Function( LoadLedgerEvent value)?  loadLedger,TResult? Function( CreateCustomerEvent value)?  createCustomer,TResult? Function( SubmitCollectPaymentEvent value)?  submitCollectPayment,TResult? Function( RecordPaymentEvent value)?  recordPayment,TResult? Function( ClearMessagesEvent value)?  clearMessages,}){
final _that = this;
switch (_that) {
case LoadCustomersEvent() when loadCustomers != null:
return loadCustomers(_that);case SearchCustomersEvent() when searchCustomers != null:
return searchCustomers(_that);case SelectCustomerEvent() when selectCustomer != null:
return selectCustomer(_that);case LoadEnrollmentsEvent() when loadEnrollments != null:
return loadEnrollments(_that);case SelectEnrollmentEvent() when selectEnrollment != null:
return selectEnrollment(_that);case LoadLedgerEvent() when loadLedger != null:
return loadLedger(_that);case CreateCustomerEvent() when createCustomer != null:
return createCustomer(_that);case SubmitCollectPaymentEvent() when submitCollectPayment != null:
return submitCollectPayment(_that);case RecordPaymentEvent() when recordPayment != null:
return recordPayment(_that);case ClearMessagesEvent() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? search)?  loadCustomers,TResult Function( String? query)?  searchCustomers,TResult Function( Customer? customer)?  selectCustomer,TResult Function( int customerId)?  loadEnrollments,TResult Function( Enrollment? enrollment)?  selectEnrollment,TResult Function( String customerId)?  loadLedger,TResult Function( String name,  String phone,  String? email,  String? address,  String? aadhar)?  createCustomer,TResult Function( int enrollmentId,  double amount,  String? paymentDate,  String paymentMode,  String? notes)?  submitCollectPayment,TResult Function( String customerId,  double amount,  String paymentMode,  String? note)?  recordPayment,TResult Function()?  clearMessages,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadCustomersEvent() when loadCustomers != null:
return loadCustomers(_that.search);case SearchCustomersEvent() when searchCustomers != null:
return searchCustomers(_that.query);case SelectCustomerEvent() when selectCustomer != null:
return selectCustomer(_that.customer);case LoadEnrollmentsEvent() when loadEnrollments != null:
return loadEnrollments(_that.customerId);case SelectEnrollmentEvent() when selectEnrollment != null:
return selectEnrollment(_that.enrollment);case LoadLedgerEvent() when loadLedger != null:
return loadLedger(_that.customerId);case CreateCustomerEvent() when createCustomer != null:
return createCustomer(_that.name,_that.phone,_that.email,_that.address,_that.aadhar);case SubmitCollectPaymentEvent() when submitCollectPayment != null:
return submitCollectPayment(_that.enrollmentId,_that.amount,_that.paymentDate,_that.paymentMode,_that.notes);case RecordPaymentEvent() when recordPayment != null:
return recordPayment(_that.customerId,_that.amount,_that.paymentMode,_that.note);case ClearMessagesEvent() when clearMessages != null:
return clearMessages();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? search)  loadCustomers,required TResult Function( String? query)  searchCustomers,required TResult Function( Customer? customer)  selectCustomer,required TResult Function( int customerId)  loadEnrollments,required TResult Function( Enrollment? enrollment)  selectEnrollment,required TResult Function( String customerId)  loadLedger,required TResult Function( String name,  String phone,  String? email,  String? address,  String? aadhar)  createCustomer,required TResult Function( int enrollmentId,  double amount,  String? paymentDate,  String paymentMode,  String? notes)  submitCollectPayment,required TResult Function( String customerId,  double amount,  String paymentMode,  String? note)  recordPayment,required TResult Function()  clearMessages,}) {final _that = this;
switch (_that) {
case LoadCustomersEvent():
return loadCustomers(_that.search);case SearchCustomersEvent():
return searchCustomers(_that.query);case SelectCustomerEvent():
return selectCustomer(_that.customer);case LoadEnrollmentsEvent():
return loadEnrollments(_that.customerId);case SelectEnrollmentEvent():
return selectEnrollment(_that.enrollment);case LoadLedgerEvent():
return loadLedger(_that.customerId);case CreateCustomerEvent():
return createCustomer(_that.name,_that.phone,_that.email,_that.address,_that.aadhar);case SubmitCollectPaymentEvent():
return submitCollectPayment(_that.enrollmentId,_that.amount,_that.paymentDate,_that.paymentMode,_that.notes);case RecordPaymentEvent():
return recordPayment(_that.customerId,_that.amount,_that.paymentMode,_that.note);case ClearMessagesEvent():
return clearMessages();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? search)?  loadCustomers,TResult? Function( String? query)?  searchCustomers,TResult? Function( Customer? customer)?  selectCustomer,TResult? Function( int customerId)?  loadEnrollments,TResult? Function( Enrollment? enrollment)?  selectEnrollment,TResult? Function( String customerId)?  loadLedger,TResult? Function( String name,  String phone,  String? email,  String? address,  String? aadhar)?  createCustomer,TResult? Function( int enrollmentId,  double amount,  String? paymentDate,  String paymentMode,  String? notes)?  submitCollectPayment,TResult? Function( String customerId,  double amount,  String paymentMode,  String? note)?  recordPayment,TResult? Function()?  clearMessages,}) {final _that = this;
switch (_that) {
case LoadCustomersEvent() when loadCustomers != null:
return loadCustomers(_that.search);case SearchCustomersEvent() when searchCustomers != null:
return searchCustomers(_that.query);case SelectCustomerEvent() when selectCustomer != null:
return selectCustomer(_that.customer);case LoadEnrollmentsEvent() when loadEnrollments != null:
return loadEnrollments(_that.customerId);case SelectEnrollmentEvent() when selectEnrollment != null:
return selectEnrollment(_that.enrollment);case LoadLedgerEvent() when loadLedger != null:
return loadLedger(_that.customerId);case CreateCustomerEvent() when createCustomer != null:
return createCustomer(_that.name,_that.phone,_that.email,_that.address,_that.aadhar);case SubmitCollectPaymentEvent() when submitCollectPayment != null:
return submitCollectPayment(_that.enrollmentId,_that.amount,_that.paymentDate,_that.paymentMode,_that.notes);case RecordPaymentEvent() when recordPayment != null:
return recordPayment(_that.customerId,_that.amount,_that.paymentMode,_that.note);case ClearMessagesEvent() when clearMessages != null:
return clearMessages();case _:
  return null;

}
}

}

/// @nodoc


class LoadCustomersEvent implements CustomerEvent {
  const LoadCustomersEvent({this.search});
  

 final  String? search;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadCustomersEventCopyWith<LoadCustomersEvent> get copyWith => _$LoadCustomersEventCopyWithImpl<LoadCustomersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadCustomersEvent&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'CustomerEvent.loadCustomers(search: $search)';
}


}

/// @nodoc
abstract mixin class $LoadCustomersEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $LoadCustomersEventCopyWith(LoadCustomersEvent value, $Res Function(LoadCustomersEvent) _then) = _$LoadCustomersEventCopyWithImpl;
@useResult
$Res call({
 String? search
});




}
/// @nodoc
class _$LoadCustomersEventCopyWithImpl<$Res>
    implements $LoadCustomersEventCopyWith<$Res> {
  _$LoadCustomersEventCopyWithImpl(this._self, this._then);

  final LoadCustomersEvent _self;
  final $Res Function(LoadCustomersEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,}) {
  return _then(LoadCustomersEvent(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SearchCustomersEvent implements CustomerEvent {
  const SearchCustomersEvent({this.query});
  

 final  String? query;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchCustomersEventCopyWith<SearchCustomersEvent> get copyWith => _$SearchCustomersEventCopyWithImpl<SearchCustomersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCustomersEvent&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'CustomerEvent.searchCustomers(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchCustomersEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $SearchCustomersEventCopyWith(SearchCustomersEvent value, $Res Function(SearchCustomersEvent) _then) = _$SearchCustomersEventCopyWithImpl;
@useResult
$Res call({
 String? query
});




}
/// @nodoc
class _$SearchCustomersEventCopyWithImpl<$Res>
    implements $SearchCustomersEventCopyWith<$Res> {
  _$SearchCustomersEventCopyWithImpl(this._self, this._then);

  final SearchCustomersEvent _self;
  final $Res Function(SearchCustomersEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = freezed,}) {
  return _then(SearchCustomersEvent(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SelectCustomerEvent implements CustomerEvent {
  const SelectCustomerEvent({this.customer});
  

 final  Customer? customer;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectCustomerEventCopyWith<SelectCustomerEvent> get copyWith => _$SelectCustomerEventCopyWithImpl<SelectCustomerEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectCustomerEvent&&(identical(other.customer, customer) || other.customer == customer));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CustomerEvent.selectCustomer(customer: $customer)';
}


}

/// @nodoc
abstract mixin class $SelectCustomerEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $SelectCustomerEventCopyWith(SelectCustomerEvent value, $Res Function(SelectCustomerEvent) _then) = _$SelectCustomerEventCopyWithImpl;
@useResult
$Res call({
 Customer? customer
});




}
/// @nodoc
class _$SelectCustomerEventCopyWithImpl<$Res>
    implements $SelectCustomerEventCopyWith<$Res> {
  _$SelectCustomerEventCopyWithImpl(this._self, this._then);

  final SelectCustomerEvent _self;
  final $Res Function(SelectCustomerEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = freezed,}) {
  return _then(SelectCustomerEvent(
customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer?,
  ));
}


}

/// @nodoc


class LoadEnrollmentsEvent implements CustomerEvent {
  const LoadEnrollmentsEvent({required this.customerId});
  

 final  int customerId;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadEnrollmentsEventCopyWith<LoadEnrollmentsEvent> get copyWith => _$LoadEnrollmentsEventCopyWithImpl<LoadEnrollmentsEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadEnrollmentsEvent&&(identical(other.customerId, customerId) || other.customerId == customerId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId);

@override
String toString() {
  return 'CustomerEvent.loadEnrollments(customerId: $customerId)';
}


}

/// @nodoc
abstract mixin class $LoadEnrollmentsEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $LoadEnrollmentsEventCopyWith(LoadEnrollmentsEvent value, $Res Function(LoadEnrollmentsEvent) _then) = _$LoadEnrollmentsEventCopyWithImpl;
@useResult
$Res call({
 int customerId
});




}
/// @nodoc
class _$LoadEnrollmentsEventCopyWithImpl<$Res>
    implements $LoadEnrollmentsEventCopyWith<$Res> {
  _$LoadEnrollmentsEventCopyWithImpl(this._self, this._then);

  final LoadEnrollmentsEvent _self;
  final $Res Function(LoadEnrollmentsEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,}) {
  return _then(LoadEnrollmentsEvent(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SelectEnrollmentEvent implements CustomerEvent {
  const SelectEnrollmentEvent({this.enrollment});
  

 final  Enrollment? enrollment;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectEnrollmentEventCopyWith<SelectEnrollmentEvent> get copyWith => _$SelectEnrollmentEventCopyWithImpl<SelectEnrollmentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectEnrollmentEvent&&(identical(other.enrollment, enrollment) || other.enrollment == enrollment));
}


@override
int get hashCode => Object.hash(runtimeType,enrollment);

@override
String toString() {
  return 'CustomerEvent.selectEnrollment(enrollment: $enrollment)';
}


}

/// @nodoc
abstract mixin class $SelectEnrollmentEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $SelectEnrollmentEventCopyWith(SelectEnrollmentEvent value, $Res Function(SelectEnrollmentEvent) _then) = _$SelectEnrollmentEventCopyWithImpl;
@useResult
$Res call({
 Enrollment? enrollment
});




}
/// @nodoc
class _$SelectEnrollmentEventCopyWithImpl<$Res>
    implements $SelectEnrollmentEventCopyWith<$Res> {
  _$SelectEnrollmentEventCopyWithImpl(this._self, this._then);

  final SelectEnrollmentEvent _self;
  final $Res Function(SelectEnrollmentEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enrollment = freezed,}) {
  return _then(SelectEnrollmentEvent(
enrollment: freezed == enrollment ? _self.enrollment : enrollment // ignore: cast_nullable_to_non_nullable
as Enrollment?,
  ));
}


}

/// @nodoc


class LoadLedgerEvent implements CustomerEvent {
  const LoadLedgerEvent({required this.customerId});
  

 final  String customerId;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadLedgerEventCopyWith<LoadLedgerEvent> get copyWith => _$LoadLedgerEventCopyWithImpl<LoadLedgerEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLedgerEvent&&(identical(other.customerId, customerId) || other.customerId == customerId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId);

@override
String toString() {
  return 'CustomerEvent.loadLedger(customerId: $customerId)';
}


}

/// @nodoc
abstract mixin class $LoadLedgerEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $LoadLedgerEventCopyWith(LoadLedgerEvent value, $Res Function(LoadLedgerEvent) _then) = _$LoadLedgerEventCopyWithImpl;
@useResult
$Res call({
 String customerId
});




}
/// @nodoc
class _$LoadLedgerEventCopyWithImpl<$Res>
    implements $LoadLedgerEventCopyWith<$Res> {
  _$LoadLedgerEventCopyWithImpl(this._self, this._then);

  final LoadLedgerEvent _self;
  final $Res Function(LoadLedgerEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,}) {
  return _then(LoadLedgerEvent(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateCustomerEvent implements CustomerEvent {
  const CreateCustomerEvent({required this.name, required this.phone, this.email, this.address, this.aadhar});
  

 final  String name;
 final  String phone;
 final  String? email;
 final  String? address;
 final  String? aadhar;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCustomerEventCopyWith<CreateCustomerEvent> get copyWith => _$CreateCustomerEventCopyWithImpl<CreateCustomerEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCustomerEvent&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.aadhar, aadhar) || other.aadhar == aadhar));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,email,address,aadhar);

@override
String toString() {
  return 'CustomerEvent.createCustomer(name: $name, phone: $phone, email: $email, address: $address, aadhar: $aadhar)';
}


}

/// @nodoc
abstract mixin class $CreateCustomerEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $CreateCustomerEventCopyWith(CreateCustomerEvent value, $Res Function(CreateCustomerEvent) _then) = _$CreateCustomerEventCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String? email, String? address, String? aadhar
});




}
/// @nodoc
class _$CreateCustomerEventCopyWithImpl<$Res>
    implements $CreateCustomerEventCopyWith<$Res> {
  _$CreateCustomerEventCopyWithImpl(this._self, this._then);

  final CreateCustomerEvent _self;
  final $Res Function(CreateCustomerEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? email = freezed,Object? address = freezed,Object? aadhar = freezed,}) {
  return _then(CreateCustomerEvent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,aadhar: freezed == aadhar ? _self.aadhar : aadhar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SubmitCollectPaymentEvent implements CustomerEvent {
  const SubmitCollectPaymentEvent({required this.enrollmentId, required this.amount, this.paymentDate, required this.paymentMode, this.notes});
  

 final  int enrollmentId;
 final  double amount;
 final  String? paymentDate;
 final  String paymentMode;
 final  String? notes;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitCollectPaymentEventCopyWith<SubmitCollectPaymentEvent> get copyWith => _$SubmitCollectPaymentEventCopyWithImpl<SubmitCollectPaymentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitCollectPaymentEvent&&(identical(other.enrollmentId, enrollmentId) || other.enrollmentId == enrollmentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,enrollmentId,amount,paymentDate,paymentMode,notes);

@override
String toString() {
  return 'CustomerEvent.submitCollectPayment(enrollmentId: $enrollmentId, amount: $amount, paymentDate: $paymentDate, paymentMode: $paymentMode, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $SubmitCollectPaymentEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $SubmitCollectPaymentEventCopyWith(SubmitCollectPaymentEvent value, $Res Function(SubmitCollectPaymentEvent) _then) = _$SubmitCollectPaymentEventCopyWithImpl;
@useResult
$Res call({
 int enrollmentId, double amount, String? paymentDate, String paymentMode, String? notes
});




}
/// @nodoc
class _$SubmitCollectPaymentEventCopyWithImpl<$Res>
    implements $SubmitCollectPaymentEventCopyWith<$Res> {
  _$SubmitCollectPaymentEventCopyWithImpl(this._self, this._then);

  final SubmitCollectPaymentEvent _self;
  final $Res Function(SubmitCollectPaymentEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enrollmentId = null,Object? amount = null,Object? paymentDate = freezed,Object? paymentMode = null,Object? notes = freezed,}) {
  return _then(SubmitCollectPaymentEvent(
enrollmentId: null == enrollmentId ? _self.enrollmentId : enrollmentId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RecordPaymentEvent implements CustomerEvent {
  const RecordPaymentEvent({required this.customerId, required this.amount, required this.paymentMode, this.note});
  

 final  String customerId;
 final  double amount;
 final  String paymentMode;
 final  String? note;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordPaymentEventCopyWith<RecordPaymentEvent> get copyWith => _$RecordPaymentEventCopyWithImpl<RecordPaymentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordPaymentEvent&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,amount,paymentMode,note);

@override
String toString() {
  return 'CustomerEvent.recordPayment(customerId: $customerId, amount: $amount, paymentMode: $paymentMode, note: $note)';
}


}

/// @nodoc
abstract mixin class $RecordPaymentEventCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory $RecordPaymentEventCopyWith(RecordPaymentEvent value, $Res Function(RecordPaymentEvent) _then) = _$RecordPaymentEventCopyWithImpl;
@useResult
$Res call({
 String customerId, double amount, String paymentMode, String? note
});




}
/// @nodoc
class _$RecordPaymentEventCopyWithImpl<$Res>
    implements $RecordPaymentEventCopyWith<$Res> {
  _$RecordPaymentEventCopyWithImpl(this._self, this._then);

  final RecordPaymentEvent _self;
  final $Res Function(RecordPaymentEvent) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? amount = null,Object? paymentMode = null,Object? note = freezed,}) {
  return _then(RecordPaymentEvent(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ClearMessagesEvent implements CustomerEvent {
  const ClearMessagesEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearMessagesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerEvent.clearMessages()';
}


}




// dart format on
