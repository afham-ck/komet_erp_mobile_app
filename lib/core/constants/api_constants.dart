class ApiConstants {
  static const String baseUrl = 'http://localhost:3000';
  static const String tokenKey = 'jwt_token';

  static const String login = '/api/auth/login/';
  static const String customers = '/api/customers/';
  static const String customerLedger = '/api/billing/invoices/customer_ledger/';
  static const String createCustomer = '/api/billing/create-customer/';
  static const String recordPayment = '/api/billing/record-payment/';
}
