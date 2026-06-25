import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komet_collection/features/customer/domain/repositories/customer_repository.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _repository;

  CustomerBloc(this._repository) : super(const CustomerState()) {
    on<LoadCustomersEvent>(_onLoadCustomers);
    on<LoadLedgerEvent>(_onLoadLedger);
    on<CreateCustomerEvent>(_onCreateCustomer);
    on<RecordPaymentEvent>(_onRecordPayment);
    on<ClearMessagesEvent>(_onClearMessages);
  }

  Future<void> _onLoadCustomers(LoadCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getCustomers();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (customers) => emit(state.copyWith(isLoading: false, customers: customers)),
    );
  }

  Future<void> _onLoadLedger(LoadLedgerEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getCustomerLedger(event.customerId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (ledger) => emit(state.copyWith(
        isLoading: false,
        invoices: ledger.invoices,
        totalDue: ledger.totalDue,
      )),
    );
  }

  Future<void> _onCreateCustomer(CreateCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.createCustomer(
      name: event.name,
      phone: event.phone,
      email: event.email,
      address: event.address,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (customer) => emit(state.copyWith(
        isLoading: false,
        successMessage: '${event.name} added successfully!',
      )),
    );
  }

  Future<void> _onRecordPayment(RecordPaymentEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.recordPayment(
      customerId: event.customerId,
      amount: event.amount,
      paymentMode: event.paymentMode,
      note: event.note,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (payment) => emit(state.copyWith(
        isLoading: false,
        successMessage: 'Payment recorded successfully!',
      )),
    );
  }

  void _onClearMessages(ClearMessagesEvent event, Emitter<CustomerState> emit) {
    emit(state.copyWith(error: null, successMessage: null));
  }
}
