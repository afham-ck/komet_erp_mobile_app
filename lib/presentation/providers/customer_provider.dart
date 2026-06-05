import 'dart:developer';
import 'package:flutter/material.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../core/error/failures.dart';
import '../../data/datasources/customer_remote_datasource.dart';
import '../../data/repositories/customer_repository_impl.dart';

class CustomerProvider extends ChangeNotifier {
  late final CustomerRepository _repository;

  CustomerProvider() {
    final dataSource = CustomerRemoteDataSource();
    _repository = CustomerRepositoryImpl(dataSource);
  }

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  List<Invoice> _invoices = [];
  List<Invoice> get invoices => _invoices;

  double _totalDue = 0;
  double get totalDue => _totalDue;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _successMessage;
  String? get successMessage => _successMessage;

  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _customers = await _repository.getCustomers();
    } on Failure catch (e) {
      _error = e.message;
      log(e.message);
    } catch (e) {
      _error = 'Failed to load customers';
      log(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadLedger(String customerId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.getCustomerLedger(customerId);
      _invoices = result.invoices;
      _totalDue = result.totalDue;
    } on Failure catch (e) {
      _error = e.message;
      log(e.message);
    } catch (e) {
      _error = 'Failed to load ledger';
      log(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.createCustomer(
        name: name,
        phone: phone,
        email: email,
        address: address,
      );
      _isLoading = false;
      _successMessage = '$name added successfully!';
      notifyListeners();
      return true;
    } on Failure catch (e) {
      _error = e.message;
      log(e.message);
    } catch (e) {
      _error = 'Failed to create customer';
      log(e.toString());
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.recordPayment(
        customerId: customerId,
        amount: amount,
        paymentMode: paymentMode,
        note: note,
      );
      _isLoading = false;
      _successMessage = 'Payment recorded successfully!';
      notifyListeners();
      return true;
    } on Failure catch (e) {
      _error = e.message;
      log(e.message);
    } catch (e) {
      _error = 'Failed to record payment';
      log(e.toString());
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
