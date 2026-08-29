import 'package:flutter_test/flutter_test.dart';
import 'package:komet_collection/features/customer/data/models/customer_model.dart';
import 'package:komet_collection/core/constants/api_constants.dart';

void main() {
  group('Customer Listing API & CustomerModel Tests', () {
    test('ApiConstants.customers endpoint should match /api/collection/customers/', () {
      expect(ApiConstants.customers, equals('/api/collection/customers/'));
    });

    test('CustomerModel.fromJson parses 200 OK API response correctly with customer_code', () {
      final jsonResponse = {
        'id': 12,
        'customer_code': 'CUST001',
        'store': 1,
        'name': 'John Doe',
        'phone': '9876543210',
        'email': 'john.doe@example.com',
        'address': '123 MG Road, Kochi, Kerala',
        'opening_balance': '0.00',
        'current_balance': '2500.00',
        'is_active': true,
        'created_at': '2026-08-20T10:30:00Z',
        'updated_at': '2026-08-29T18:00:00Z'
      };

      final model = CustomerModel.fromJson(jsonResponse);

      expect(model.id, equals('12'));
      expect(model.code, equals('CUST001'));
      expect(model.name, equals('John Doe'));
      expect(model.phone, equals('9876543210'));
      expect(model.email, equals('john.doe@example.com'));
      expect(model.address, equals('123 MG Road, Kochi, Kerala'));
      expect(model.totalDue, equals(2500.00));
      expect(model.createdAt, equals(DateTime.parse('2026-08-20T10:30:00Z')));
    });
  });
}
