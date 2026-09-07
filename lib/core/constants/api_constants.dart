class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String login = '/api/auth/login/';
  static const String refreshToken = '/api/auth/token/refresh/';
  static const String customers = '/api/collection/customers/';
  static const String customerDetail = '/api/collection/customers/detail/';
  static const String customerLedger = '/api/billing/invoices/customer_ledger/';
  static const String createCustomer = '/api/collection/customers/';
  static const String enrollments = '/api/collection/enrollments/';
  static const String recordPayment = '/api/collection/installments/pay/';
  static const String collectPayment = '/api/collection/installments/pay/';
}
