import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_event.freezed.dart';

@freezed
class CustomerEvent with _$CustomerEvent {
  const factory CustomerEvent.loadCustomers() = LoadCustomersEvent;
  const factory CustomerEvent.loadLedger({required String customerId}) = LoadLedgerEvent;
  const factory CustomerEvent.createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? aadhar,
  }) = CreateCustomerEvent;
  const factory CustomerEvent.recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) = RecordPaymentEvent;
  const factory CustomerEvent.clearMessages() = ClearMessagesEvent;
}
