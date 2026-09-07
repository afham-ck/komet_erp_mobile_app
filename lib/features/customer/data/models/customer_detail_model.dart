import 'package:komet_collection/features/customer/domain/entities/customer_detail_entity.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_scheme.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_transaction.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_detail_data.dart';

double _parseDouble(dynamic val) {
  if (val == null) return 0.0;
  if (val is num) return val.toDouble();
  if (val is String) return double.tryParse(val) ?? 0.0;
  return 0.0;
}

int _parseInt(dynamic val) {
  if (val == null) return 0;
  if (val is num) return val.toInt();
  if (val is String) return int.tryParse(val) ?? 0;
  return 0;
}

class CustomerDetailInfoModel extends CustomerDetailEntity {
  const CustomerDetailInfoModel({
    required super.id,
    required super.customerCode,
    required super.name,
    required super.phone,
    super.address,
    super.email,
    super.aadhar,
    super.isActive,
    super.totalDueAmount,
    super.overdueAmount,
    super.nextDueDate,
    super.createdAt,
    super.updatedAt,
  });

  factory CustomerDetailInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailInfoModel(
      id: _parseInt(json['id']),
      customerCode: json['customer_code']?.toString() ?? json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString(),
      email: json['email']?.toString(),
      aadhar: json['aadhar']?.toString(),
      isActive: json['is_active'] is bool ? json['is_active'] as bool : true,
      totalDueAmount: _parseDouble(json['total_due_amount'] ?? json['total_due'] ?? json['current_balance']),
      overdueAmount: _parseDouble(json['overdue_amount']),
      nextDueDate: json['next_due_date']?.toString(),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer_code': customerCode,
    'name': name,
    'phone': phone,
    'address': address,
    'email': email,
    'aadhar': aadhar,
    'is_active': isActive,
    'total_due_amount': totalDueAmount,
    'overdue_amount': overdueAmount,
    'next_due_date': nextDueDate,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class CustomerSchemeModel extends CustomerScheme {
  const CustomerSchemeModel({
    required super.enrollmentId,
    required super.schemeId,
    required super.schemeName,
    required super.durationType,
    required super.durationCount,
    required super.durationGapDays,
    required super.installmentAmount,
    required super.totalAmount,
    required super.maturityAmount,
    super.startDate,
    super.endDate,
    super.nextDueDate,
    required super.status,
    required super.totalPaid,
    required super.balanceDue,
    required super.totalInstallments,
    required super.paidInstallments,
    required super.hasOverdue,
    super.notes,
    super.createdAt,
  });

  factory CustomerSchemeModel.fromJson(Map<String, dynamic> json) {
    return CustomerSchemeModel(
      enrollmentId: _parseInt(json['enrollment_id']),
      schemeId: _parseInt(json['scheme_id']),
      schemeName: json['scheme_name']?.toString() ?? '',
      durationType: json['duration_type']?.toString() ?? '',
      durationCount: _parseInt(json['duration_count']),
      durationGapDays: _parseInt(json['duration_gap_days']),
      installmentAmount: _parseDouble(json['installment_amount']),
      totalAmount: _parseDouble(json['total_amount']),
      maturityAmount: _parseDouble(json['maturity_amount']),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      nextDueDate: json['next_due_date']?.toString(),
      status: json['status']?.toString() ?? 'active',
      totalPaid: _parseDouble(json['total_paid']),
      balanceDue: _parseDouble(json['balance_due']),
      totalInstallments: _parseInt(json['total_installments']),
      paidInstallments: _parseInt(json['paid_installments']),
      hasOverdue: json['has_overdue'] is bool ? json['has_overdue'] as bool : false,
      notes: json['notes']?.toString(),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'enrollment_id': enrollmentId,
    'scheme_id': schemeId,
    'scheme_name': schemeName,
    'duration_type': durationType,
    'duration_count': durationCount,
    'duration_gap_days': durationGapDays,
    'installment_amount': installmentAmount,
    'total_amount': totalAmount,
    'maturity_amount': maturityAmount,
    'start_date': startDate,
    'end_date': endDate,
    'next_due_date': nextDueDate,
    'status': status,
    'total_paid': totalPaid,
    'balance_due': balanceDue,
    'total_installments': totalInstallments,
    'paid_installments': paidInstallments,
    'has_overdue': hasOverdue,
    'notes': notes,
    'created_at': createdAt?.toIso8601String(),
  };
}

class PaymentClosedModel extends PaymentClosed {
  const PaymentClosedModel({
    required super.installmentId,
    required super.installmentNumber,
    super.dueDate,
    required super.installmentAmount,
    required super.amountApplied,
    required super.status,
  });

  factory PaymentClosedModel.fromJson(Map<String, dynamic> json) {
    return PaymentClosedModel(
      installmentId: _parseInt(json['installment_id']),
      installmentNumber: _parseInt(json['installment_number']),
      dueDate: json['due_date']?.toString(),
      installmentAmount: _parseDouble(json['installment_amount']),
      amountApplied: _parseDouble(json['amount_applied']),
      status: json['status']?.toString() ?? 'paid',
    );
  }

  Map<String, dynamic> toJson() => {
    'installment_id': installmentId,
    'installment_number': installmentNumber,
    'due_date': dueDate,
    'installment_amount': installmentAmount,
    'amount_applied': amountApplied,
    'status': status,
  };
}

class CustomerTransactionModel extends CustomerTransaction {
  const CustomerTransactionModel({
    required super.transactionId,
    required super.receiptNo,
    required super.amount,
    super.paymentDate,
    required super.paymentMode,
    required super.receivedBy,
    super.notes,
    super.enrollmentId,
    super.schemeId,
    super.schemeName,
    super.paymentsClosed,
  });

  factory CustomerTransactionModel.fromJson(Map<String, dynamic> json) {
    final rawClosed = json['payments_closed'];
    List<PaymentClosedModel> closedList = [];
    if (rawClosed is List) {
      closedList = rawClosed
          .map((e) => PaymentClosedModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return CustomerTransactionModel(
      transactionId: _parseInt(json['transaction_id']),
      receiptNo: json['receipt_no']?.toString() ?? '',
      amount: _parseDouble(json['amount']),
      paymentDate: json['payment_date']?.toString(),
      paymentMode: json['payment_mode']?.toString() ?? '',
      receivedBy: json['received_by']?.toString() ?? '',
      notes: json['notes']?.toString(),
      enrollmentId: json['enrollment_id'] != null ? _parseInt(json['enrollment_id']) : null,
      schemeId: json['scheme_id'] != null ? _parseInt(json['scheme_id']) : null,
      schemeName: json['scheme_name']?.toString(),
      paymentsClosed: closedList,
    );
  }

  Map<String, dynamic> toJson() => {
    'transaction_id': transactionId,
    'receipt_no': receiptNo,
    'amount': amount,
    'payment_date': paymentDate,
    'payment_mode': paymentMode,
    'received_by': receivedBy,
    'notes': notes,
    'enrollment_id': enrollmentId,
    'scheme_id': schemeId,
    'scheme_name': schemeName,
    'payments_closed': (paymentsClosed as List<PaymentClosedModel>)
        .map((e) => e.toJson())
        .toList(),
  };
}

class CustomerDetailDataModel extends CustomerDetailData {
  const CustomerDetailDataModel({
    required super.customer,
    super.schemes,
    super.transactions,
  });

  factory CustomerDetailDataModel.fromJson(Map<String, dynamic> json) {
    final customerJson = json['customer'] as Map<String, dynamic>? ?? {};
    final schemesJson = json['schemes'] as List? ?? [];
    final transactionsJson = json['transactions'] as List? ?? [];

    return CustomerDetailDataModel(
      customer: CustomerDetailInfoModel.fromJson(customerJson),
      schemes: schemesJson
          .map((e) => CustomerSchemeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: transactionsJson
          .map((e) => CustomerTransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
