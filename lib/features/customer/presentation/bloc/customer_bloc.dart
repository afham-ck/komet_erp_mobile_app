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
    on<SearchCustomersEvent>(_onSearchCustomers);
    on<SelectCustomerEvent>(_onSelectCustomer);
    on<LoadEnrollmentsEvent>(_onLoadEnrollments);
    on<SelectEnrollmentEvent>(_onSelectEnrollment);
    on<LoadLedgerEvent>(_onLoadLedger);
    on<CreateCustomerEvent>(_onCreateCustomer);
    on<SubmitCollectPaymentEvent>(_onSubmitCollectPayment);
    on<RecordPaymentEvent>(_onRecordPayment);
    on<ClearMessagesEvent>(_onClearMessages);
  }

  Future<void> _onLoadCustomers(
      LoadCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getCustomers(search: event.search);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (customers) =>
          emit(state.copyWith(isLoading: false, customers: customers, customerSearchResults: customers)),
    );
  }

  Future<void> _onSearchCustomers(
      SearchCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isSearchingCustomers: true, error: null));
    final result = await _repository.getCustomers(search: event.query);
    result.fold(
      (failure) => emit(state.copyWith(isSearchingCustomers: false, error: failure.message)),
      (customers) =>
          emit(state.copyWith(isSearchingCustomers: false, customerSearchResults: customers)),
    );
  }

  Future<void> _onSelectCustomer(
      SelectCustomerEvent event, Emitter<CustomerState> emit) async {
    final customer = event.customer;
    emit(state.copyWith(
      selectedCustomer: customer,
      enrollments: [],
      selectedEnrollment: null,
      error: null,
    ));

    if (customer != null) {
      final custId = int.tryParse(customer.id);
      if (custId != null) {
        add(CustomerEvent.loadEnrollments(customerId: custId));
      }
    }
  }

  Future<void> _onLoadEnrollments(
      LoadEnrollmentsEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoadingEnrollments: true, error: null));
    final result = await _repository.getEnrollments(customerId: event.customerId);
    result.fold(
      (failure) => emit(state.copyWith(isLoadingEnrollments: false, error: failure.message)),
      (enrollments) {
        final selected = enrollments.isNotEmpty ? enrollments.first : null;
        emit(state.copyWith(
          isLoadingEnrollments: false,
          enrollments: enrollments,
          selectedEnrollment: selected,
        ));
      },
    );
  }

  void _onSelectEnrollment(
      SelectEnrollmentEvent event, Emitter<CustomerState> emit) {
    emit(state.copyWith(selectedEnrollment: event.enrollment));
  }

  Future<void> _onLoadLedger(
      LoadLedgerEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getCustomerDetail(event.customerId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (detailData) => emit(state.copyWith(
        isLoading: false,
        customerDetailData: detailData,
        totalDue: detailData.customer.totalDueAmount,
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

    String? errorMsg;
    String? createdName;
    result.fold(
      (failure) => errorMsg = failure.message,
      (customer) => createdName = customer.name,
    );

    if (errorMsg != null) {
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

    emit(state.copyWith(isLoading: false));

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

      _appRouter.navigatorKey.currentState?.pop();
    }

    emit(state.copyWith(customers: [], isLoading: true));
    final refreshResult = await _repository.getCustomers();
    refreshResult.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (customers) =>
          emit(state.copyWith(isLoading: false, customers: customers)),
    );
  }

  Future<void> _onSubmitCollectPayment(
      SubmitCollectPaymentEvent event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, paymentResult: null));
    final result = await _repository.collectPayment(
      enrollmentId: event.enrollmentId,
      amount: event.amount,
      paymentDate: event.paymentDate,
      paymentMode: event.paymentMode,
      notes: event.notes,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (paymentResult) => emit(state.copyWith(
        isLoading: false,
        paymentResult: paymentResult,
        successMessage: 'Payment of ₹${paymentResult.amount.toStringAsFixed(2)} recorded successfully!',
      )),
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
    emit(state.copyWith(error: null, successMessage: null, paymentResult: null));
  }
}
