import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komet_collection/core/router/app_router.dart';
import 'package:komet_collection/core/widgets/error_tile.dart';
import 'package:komet_collection/core/widgets/success_tile.dart';
import 'package:komet_collection/features/customer/domain/repositories/customer_repository.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _repository;
  final AppRouter _appRouter;

  CustomerBloc(this._repository, this._appRouter)
      : super(const CustomerState()) {
    on<LoadCustomersEvent>(_onLoadCustomers);
    on<LoadLedgerEvent>(_onLoadLedger);
    on<CreateCustomerEvent>(_onCreateCustomer);
    on<RecordPaymentEvent>(_onRecordPayment);
    on<ClearMessagesEvent>(_onClearMessages);
  }

  Future<void> _onLoadCustomers(
      LoadCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getCustomers();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (customers) =>
          emit(state.copyWith(isLoading: false, customers: customers)),
    );
  }

  Future<void> _onLoadLedger(
      LoadLedgerEvent event, Emitter<CustomerState> emit) async {
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

  Future<void> _onCreateCustomer(
      CreateCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _repository.createCustomer(
      name: event.name,
      phone: event.phone,
      email: event.email,
      address: event.address,
      aadhar: event.aadhar,
    );

    // Extract outcome without async in fold
    String? errorMsg;
    String? createdName;
    result.fold(
      (failure) => errorMsg = failure.message,
      (customer) => createdName = customer.name,
    );

    if (errorMsg != null) {
      // Stop loading then show the error as a dialog via the AppRouter key
      emit(state.copyWith(isLoading: false));
      final errContext = _appRouter.navigatorKey.currentContext;
      if (errContext != null) {
        // ignore: use_build_context_synchronously
        await showDialog<void>(context: errContext, barrierDismissible: false, builder: (dialogContext) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: ErrorTile(
              title: 'Creation Failed',
              message: errorMsg!,
              buttonText: 'Okay',
              margin: EdgeInsets.zero,
              onRetry: () => Navigator.of(dialogContext).pop(),
            ),
          ),
        );
      }
      return;
    }

    // Success — stop loading spinner first
    emit(state.copyWith(isLoading: false));

    // Show the success dialog imperatively via the AppRouter's navigator key.
    // AppRouter (RootStackRouter) holds a GlobalKey<NavigatorState> scoped to
    // the app lifecycle — async usage is intentionally safe here.
    final navContext = _appRouter.navigatorKey.currentContext;
    if (navContext != null) {
      // ignore: use_build_context_synchronously
      await showDialog<void>(context: navContext, barrierDismissible: false, builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: SuccessTile(
            title: 'Customer Added!',
            message: '$createdName has been successfully added to your customer list.',
            buttonText: 'Done',
            margin: EdgeInsets.zero,
            onDismiss: () => Navigator.of(dialogContext).pop(),
          ),
        ),
      );

      // Pop the AddCustomer screen after the dialog is dismissed
      _appRouter.navigatorKey.currentState?.pop();
    }

    // Refresh customer list: clear existing entries then re-fetch first batch
    emit(state.copyWith(customers: [], isLoading: true));
    final refreshResult = await _repository.getCustomers();
    refreshResult.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (customers) =>
          emit(state.copyWith(isLoading: false, customers: customers)),
    );
  }

  Future<void> _onRecordPayment(
      RecordPaymentEvent event, Emitter<CustomerState> emit) async {
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
