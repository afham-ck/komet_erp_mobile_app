import 'package:flutter_test/flutter_test.dart';
import 'package:komet_collection/features/customer/data/models/customer_detail_model.dart';
import 'package:komet_collection/core/constants/api_constants.dart';

void main() {
  group('Customer Detail API & Deserialization Tests', () {
    test('ApiConstants.customerDetail matches /api/collection/customers/detail/', () {
      expect(ApiConstants.customerDetail, equals('/api/collection/customers/detail/'));
    });

    test('CustomerDetailDataModel parses Customer with Schemes & Transactions', () {
      final jsonResponse = {
        "customer": {
          "id": 1,
          "customer_code": "RUBC000001",
          "name": "Anil Kumar",
          "phone": "9876543210",
          "address": "MG Road, Kochi, Kerala",
          "email": "anil@example.com",
          "aadhar": "123456789012",
          "is_active": true,
          "total_due_amount": 10000.0,
          "overdue_amount": 1000.0,
          "next_due_date": "2026-04-01",
          "created_at": "2026-08-15T10:30:00Z",
          "updated_at": "2026-08-15T10:30:00Z"
        },
        "schemes": [
          {
            "enrollment_id": 10,
            "scheme_id": 2,
            "scheme_name": "Gold Savings Scheme 2026",
            "duration_type": "monthly",
            "duration_count": 12,
            "duration_gap_days": 30,
            "installment_amount": 1000.0,
            "total_amount": 12000.0,
            "maturity_amount": 13200.0,
            "start_date": "2026-01-01",
            "end_date": "2026-12-27",
            "next_due_date": "2026-04-01",
            "status": "active",
            "total_paid": 2000.0,
            "balance_due": 10000.0,
            "total_installments": 12,
            "paid_installments": 2,
            "has_overdue": true,
            "notes": "Regular subscriber",
            "created_at": "2026-01-01T10:00:00Z"
          }
        ],
        "transactions": [
          {
            "transaction_id": 45,
            "receipt_no": "REC-2026-0001-0012",
            "amount": 2000.0,
            "payment_date": "2026-01-15",
            "payment_mode": "cash",
            "received_by": "Staff Admin",
            "notes": "Paid for Installments 1 & 2",
            "enrollment_id": 10,
            "scheme_id": 2,
            "scheme_name": "Gold Savings Scheme 2026",
            "payments_closed": [
              {
                "installment_id": 101,
                "installment_number": 1,
                "due_date": "2026-01-31",
                "installment_amount": 1000.0,
                "amount_applied": 1000.0,
                "status": "paid"
              },
              {
                "installment_id": 102,
                "installment_number": 2,
                "due_date": "2026-03-02",
                "installment_amount": 1000.0,
                "amount_applied": 1000.0,
                "status": "paid"
              }
            ]
          }
        ]
      };

      final dataModel = CustomerDetailDataModel.fromJson(jsonResponse);

      // Verify Customer Details
      expect(dataModel.customer.id, equals(1));
      expect(dataModel.customer.customerCode, equals("RUBC000001"));
      expect(dataModel.customer.name, equals("Anil Kumar"));
      expect(dataModel.customer.phone, equals("9876543210"));
      expect(dataModel.customer.totalDueAmount, equals(10000.0));
      expect(dataModel.customer.overdueAmount, equals(1000.0));
      expect(dataModel.customer.nextDueDate, equals("2026-04-01"));
      expect(dataModel.customer.isActive, isTrue);

      // Verify Schemes
      expect(dataModel.schemes.length, equals(1));
      final scheme = dataModel.schemes.first;
      expect(scheme.enrollmentId, equals(10));
      expect(scheme.schemeName, equals("Gold Savings Scheme 2026"));
      expect(scheme.installmentAmount, equals(1000.0));
      expect(scheme.totalAmount, equals(12000.0));
      expect(scheme.maturityAmount, equals(13200.0));
      expect(scheme.totalPaid, equals(2000.0));
      expect(scheme.balanceDue, equals(10000.0));
      expect(scheme.paidInstallments, equals(2));
      expect(scheme.totalInstallments, equals(12));
      expect(scheme.hasOverdue, isTrue);

      // Verify Transactions
      expect(dataModel.transactions.length, equals(1));
      final tx = dataModel.transactions.first;
      expect(tx.transactionId, equals(45));
      expect(tx.receiptNo, equals("REC-2026-0001-0012"));
      expect(tx.amount, equals(2000.0));
      expect(tx.paymentMode, equals("cash"));
      expect(tx.receivedBy, equals("Staff Admin"));
      expect(tx.paymentsClosed.length, equals(2));
      expect(tx.paymentsClosed[0].installmentNumber, equals(1));
      expect(tx.paymentsClosed[0].amountApplied, equals(1000.0));
      expect(tx.paymentsClosed[1].installmentNumber, equals(2));
      expect(tx.paymentsClosed[1].amountApplied, equals(1000.0));
    });

    test('CustomerDetailDataModel parses Customer with No Schemes Allocated', () {
      final jsonResponse = {
        "customer": {
          "id": 2,
          "customer_code": "RUBC000002",
          "name": "Suresh P",
          "phone": "9123456789",
          "address": "Pala, Kottayam",
          "email": "",
          "aadhar": "",
          "is_active": true,
          "total_due_amount": 0.0,
          "overdue_amount": 0.0,
          "next_due_date": null,
          "created_at": "2026-09-01T09:00:00Z",
          "updated_at": "2026-09-01T09:00:00Z"
        },
        "schemes": [],
        "transactions": []
      };

      final dataModel = CustomerDetailDataModel.fromJson(jsonResponse);

      expect(dataModel.customer.id, equals(2));
      expect(dataModel.customer.customerCode, equals("RUBC000002"));
      expect(dataModel.customer.name, equals("Suresh P"));
      expect(dataModel.customer.totalDueAmount, equals(0.0));
      expect(dataModel.customer.overdueAmount, equals(0.0));
      expect(dataModel.customer.nextDueDate, isNull);
      expect(dataModel.schemes, isEmpty);
      expect(dataModel.transactions, isEmpty);
    });
  });
}
