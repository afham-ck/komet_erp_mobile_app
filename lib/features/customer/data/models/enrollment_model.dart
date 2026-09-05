import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';

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

class EnrollmentModel extends Enrollment {
  const EnrollmentModel({
    required super.id,
    super.scheme,
    required super.schemeName,
    super.customer,
    super.customerCode,
    super.customerName,
    super.customerPhone,
    super.startDate,
    super.endDate,
    required super.status,
    required super.totalPaid,
    required super.balanceDue,
    required super.hasOverdue,
    required super.maturityAmount,
    required super.installmentAmount,
    required super.totalSchemeAmount,
    super.nextDueDate,
    required super.totalInstallments,
    required super.paidInstallments,
    super.notes,
    super.createdAt,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: _parseInt(json['id'] ?? json['enrollmentId'] ?? json['enrollment_id']),
      scheme: json['scheme'] != null ? _parseInt(json['scheme']) : null,
      schemeName: json['schemeName']?.toString() ?? json['scheme_name']?.toString() ?? '',
      customer: json['customer'] != null ? _parseInt(json['customer']) : null,
      customerCode: json['customerCode']?.toString() ?? json['customer_code']?.toString(),
      customerName: json['customerName']?.toString() ?? json['customer_name']?.toString(),
      customerPhone: json['customerPhone']?.toString() ?? json['customer_phone']?.toString(),
      startDate: json['startDate']?.toString() ?? json['start_date']?.toString(),
      endDate: json['endDate']?.toString() ?? json['end_date']?.toString(),
      status: json['status']?.toString() ?? 'active',
      totalPaid: _parseDouble(json['totalPaid'] ?? json['total_paid']),
      balanceDue: _parseDouble(json['balanceDue'] ?? json['balance_due']),
      hasOverdue: json['hasOverdue'] is bool
          ? json['hasOverdue'] as bool
          : (json['has_overdue'] is bool ? json['has_overdue'] as bool : false),
      maturityAmount: _parseDouble(json['maturityAmount'] ?? json['maturity_amount']),
      installmentAmount: _parseDouble(json['installmentAmount'] ?? json['installment_amount']),
      totalSchemeAmount: _parseDouble(json['totalSchemeAmount'] ?? json['total_scheme_amount'] ?? json['total_amount']),
      nextDueDate: json['nextDueDate']?.toString() ?? json['next_due_date']?.toString(),
      totalInstallments: _parseInt(json['totalInstallments'] ?? json['total_installments']),
      paidInstallments: _parseInt(json['paidInstallments'] ?? json['paid_installments']),
      notes: json['notes']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'scheme': scheme,
        'schemeName': schemeName,
        'customer': customer,
        'customerCode': customerCode,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'startDate': startDate,
        'endDate': endDate,
        'status': status,
        'totalPaid': totalPaid,
        'balanceDue': balanceDue,
        'hasOverdue': hasOverdue,
        'maturityAmount': maturityAmount,
        'installmentAmount': installmentAmount,
        'totalSchemeAmount': totalSchemeAmount,
        'nextDueDate': nextDueDate,
        'totalInstallments': totalInstallments,
        'paidInstallments': paidInstallments,
        'notes': notes,
        'created_at': createdAt,
      };
}
