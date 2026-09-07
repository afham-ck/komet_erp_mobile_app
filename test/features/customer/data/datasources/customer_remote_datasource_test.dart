import 'package:flutter_test/flutter_test.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/features/customer/data/models/customer_model.dart';
import 'package:komet_collection/features/customer/data/models/enrollment_model.dart';
import 'package:komet_collection/features/customer/data/models/payment_result_model.dart';

void main() {
  group('Collection REST APIs & Data Models Tests', () {
    test('ApiConstants collection endpoints match specification', () {
      expect(ApiConstants.customers, equals('/api/collection/customers/'));
      expect(ApiConstants.enrollments, equals('/api/collection/enrollments/'));
      expect(ApiConstants.collectPayment, equals('/api/collection/installments/pay/'));
    });

    test('CustomerModel.fromJson parses 200 OK API response correctly with customer_code', () {
      final jsonResponse = {
        'id': 12,
        'customer_code': 'CUST000012',
        'name': 'Adil Khan',
        'phone': '9876543210',
        'email': 'adil@example.com',
        'address': '123 Main Street',
        'total_due_amount': 2000.0,
        'overdue_amount': 1000.0,
        'next_due_date': '2026-09-15',
        'is_active': true,
        'created_at': '2026-01-10T10:30:00Z'
      };

      final model = CustomerModel.fromJson(jsonResponse);

      expect(model.id, equals('12'));
      expect(model.code, equals('CUST000012'));
      expect(model.name, equals('Adil Khan'));
      expect(model.phone, equals('9876543210'));
      expect(model.email, equals('adil@example.com'));
      expect(model.address, equals('123 Main Street'));
      expect(model.totalDue, equals(2000.00));
      expect(model.overdueAmount, equals(1000.00));
      expect(model.nextDueDate, equals('2026-09-15'));
      expect(model.isActive, isTrue);
    });

    test('EnrollmentModel.fromJson parses API #2 enrollment response correctly', () {
      final jsonResponse = {
        'id': 5,
        'scheme': 2,
        'schemeName': 'Gold Savings Plan',
        'customer': 12,
        'customerCode': 'CUST000012',
        'customerName': 'Adil Khan',
        'customerPhone': '9876543210',
        'startDate': '2026-01-01',
        'endDate': '2026-12-31',
        'status': 'active',
        'totalPaid': 3000.0,
        'balanceDue': 9000.0,
        'hasOverdue': true,
        'maturityAmount': 12000.0,
        'installmentAmount': 1000.0,
        'totalSchemeAmount': 12000.0,
        'nextDueDate': '2026-09-15',
        'totalInstallments': 12,
        'paidInstallments': 3,
        'notes': 'Store enrollment',
        'created_at': '2026-01-01T09:00:00Z'
      };

      final model = EnrollmentModel.fromJson(jsonResponse);

      expect(model.id, equals(5));
      expect(model.schemeName, equals('Gold Savings Plan'));
      expect(model.customer, equals(12));
      expect(model.customerCode, equals('CUST000012'));
      expect(model.status, equals('active'));
      expect(model.totalPaid, equals(3000.0));
      expect(model.balanceDue, equals(9000.0));
      expect(model.hasOverdue, isTrue);
      expect(model.installmentAmount, equals(1000.0));
      expect(model.totalSchemeAmount, equals(12000.0));
      expect(model.nextDueDate, equals('2026-09-15'));
      expect(model.totalInstallments, equals(12));
      expect(model.paidInstallments, equals(3));
    });

    test('PaymentResultModel.fromJson parses API #3 mark collect payment response correctly', () {
      final jsonResponse = {
        'status': 'recorded',
        'transaction_id': 42,
        'receipt_number': 'REC-2026-0001-0042',
        'amount': 1000.0,
        'payment_date': '2026-09-05',
        'payment_mode': 'cash',
        'received_by': 'Adil Staff',
        'created_by_username': 'adil_staff',
        'created_by_id': 3,
        'customer_name': 'Adil Khan',
        'scheme_name': 'Gold Savings Plan',
        'installments_fully_paid': [4],
        'installments_partially_paid': []
      };

      final model = PaymentResultModel.fromJson(jsonResponse);

      expect(model.status, equals('recorded'));
      expect(model.transactionId, equals(42));
      expect(model.receiptNumber, equals('REC-2026-0001-0042'));
      expect(model.amount, equals(1000.0));
      expect(model.paymentDate, equals('2026-09-05'));
      expect(model.paymentMode, equals('cash'));
      expect(model.receivedBy, equals('Adil Staff'));
      expect(model.customerName, equals('Adil Khan'));
      expect(model.schemeName, equals('Gold Savings Plan'));
      expect(model.installmentsFullyPaid, equals([4]));
    });
  });
}
