import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';

part 'customer_event.freezed.dart';

@freezed
class CustomerEvent with _$CustomerEvent {
  const factory CustomerEvent.loadCustomers({String? search}) = LoadCustomersEvent;
  const factory CustomerEvent.searchCustomers({String? query}) = SearchCustomersEvent;
  const factory CustomerEvent.selectCustomer({Customer? customer}) = SelectCustomerEvent;
  const factory CustomerEvent.loadEnrollments({required int customerId}) = LoadEnrollmentsEvent;
  const factory CustomerEvent.selectEnrollment({Enrollment? enrollment}) = SelectEnrollmentEvent;
  const factory CustomerEvent.loadLedger({required String customerId}) = LoadLedgerEvent;
  const factory CustomerEvent.createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? aadhar,
  }) = CreateCustomerEvent;
  const factory CustomerEvent.submitCollectPayment({
    required int enrollmentId,
    required double amount,
    String? paymentDate,
    required String paymentMode,
    String? notes,
  }) = SubmitCollectPaymentEvent;
  const factory CustomerEvent.recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) = RecordPaymentEvent;
  const factory CustomerEvent.clearMessages() = ClearMessagesEvent;
}
