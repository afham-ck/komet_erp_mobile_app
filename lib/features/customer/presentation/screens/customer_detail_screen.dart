import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_detail_entity.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_scheme.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_transaction.dart';
import 'package:komet_collection/core/router/app_router.gr.dart';
import 'package:komet_collection/core/widgets/error_tile.dart';

@RoutePage()
class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;
  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Customer _customer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _customer = widget.customer;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CustomerBloc>()
          .add(CustomerEvent.loadLedger(customerId: _customer.id));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDateString(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      final parsed = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) context.router.pop(_customer);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text(
            _customer.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                context
                    .read<CustomerBloc>()
                    .add(CustomerEvent.loadLedger(customerId: _customer.id));
              },
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            final detailData = state.customerDetailData;
            final customerDetail = detailData?.customer;
            final schemes = detailData?.schemes ?? [];
            final transactions = detailData?.transactions ?? [];

            if (state.isLoading && detailData == null) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<CustomerBloc>()
                    .add(CustomerEvent.loadLedger(customerId: _customer.id));
              },
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _buildHeaderCard(context, customerDetail),
                          if (state.error != null)
                            ErrorTile(
                              message: state.error!,
                              onRetry: () {
                                context.read<CustomerBloc>().add(
                                    CustomerEvent.loadLedger(
                                        customerId: _customer.id));
                              },
                            ),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverTabBarDelegate(
                        child: _buildTabBar(schemes.length, transactions.length),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildSchemesTab(schemes),
                    _buildTransactionsTab(transactions),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, CustomerDetailEntity? detail) {
    final name = detail?.name ?? _customer.name;
    final code = detail?.customerCode ?? _customer.code ?? '';
    final phone = detail?.phone ?? _customer.phone;
    final email = detail?.email ?? _customer.email;
    final address = detail?.address ?? _customer.address;
    final nextDueDate = detail?.nextDueDate;
    final totalDue = detail?.totalDueAmount ?? _customer.totalDue;
    final overdue = detail?.overdueAmount ?? 0.0;
    final isActive = detail?.isActive ?? true;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isActive
                                  ? const Color(0xFF34D399)
                                  : const Color(0xFF94A3B8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFF34D399)
                                      : const Color(0xFF94A3B8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isActive ? 'ACTIVE' : 'INACTIVE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isActive
                                      ? const Color(0xFF34D399)
                                      : const Color(0xFFCBD5E1),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (code.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Code: $code',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded,
                            size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          phone,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFE2E8F0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (email != null && email.isNotEmpty) ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.email_rounded,
                              size: 14, color: Color(0xFF818CF8)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              email,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFCBD5E1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (address != null && address.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 14, color: Color(0xFF818CF8)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: 'Next Due Amount',
                  value: '₹${totalDue.toStringAsFixed(2)}',
                  subtitle: overdue > 0 ? 'Overdue: ₹${overdue.toStringAsFixed(2)}' : null,
                  valueColor: totalDue > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                  icon: Icons.account_balance_wallet_rounded,
                  iconBg: totalDue > 0
                      ? const Color(0xFFFEE2E2)
                      : const Color(0xFFD1FAE5),
                  iconColor: totalDue > 0
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF059669),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricTile(
                  label: 'Next Due Date',
                  value: _formatDateString(nextDueDate),
                  subtitle: nextDueDate != null ? 'Upcoming' : 'No dues pending',
                  valueColor: const Color(0xFF0F172A),
                  icon: Icons.event_rounded,
                  iconBg: const Color(0xFFEEF2FF),
                  iconColor: const Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                final bloc = context.read<CustomerBloc>();
                await context.router.push(CollectPaymentRoute(customer: _customer));
                if (mounted) {
                  bloc.add(CustomerEvent.loadLedger(customerId: _customer.id));
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Collect Payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    String? subtitle,
    required Color valueColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: valueColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: subtitle.contains('Overdue')
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(int schemesCount, int transactionsCount) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF0F172A),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF64748B),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.stars_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text('Schemes ($schemesCount)'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text('Transactions ($transactionsCount)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchemesTab(List<CustomerScheme> schemes) {
    if (schemes.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEF2FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.card_membership_rounded,
                          size: 48,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No active schemes enrolled',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'This customer has not subscribed to any gold/savings schemes yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        final scheme = schemes[index];
        return _AnimatedSchemeCard(
          scheme: scheme,
          formatDate: _formatDateString,
          index: index,
        );
      },
    );
  }

  Widget _buildTransactionsTab(List<CustomerTransaction> transactions) {
    if (transactions.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.receipt_long_rounded,
                          size: 48,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No transactions recorded',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'There are no payment collection transactions for this customer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _AnimatedTransactionCard(
          transaction: tx,
          formatDate: _formatDateString,
          index: index,
        );
      },
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverTabBarDelegate({required this.child});

  @override
  double get minExtent => 56.0;

  @override
  double get maxExtent => 56.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

class _AnimatedSchemeCard extends StatelessWidget {
  final CustomerScheme scheme;
  final String Function(String?) formatDate;
  final int index;

  const _AnimatedSchemeCard({
    required this.scheme,
    required this.formatDate,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final progress = scheme.totalInstallments > 0
        ? (scheme.paidInstallments / scheme.totalInstallments).clamp(0.0, 1.0)
        : 0.0;

    final isCompleted = scheme.status.toLowerCase() == 'completed';
    final statusColor = isCompleted
        ? const Color(0xFF2563EB)
        : scheme.status.toLowerCase() == 'active'
            ? const Color(0xFF059669)
            : const Color(0xFF64748B);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(0, (1 - animValue) * 20),
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: scheme.hasOverdue
                ? const Color(0xFFFCA5A5)
                : const Color(0xFFE2E8F0),
            width: scheme.hasOverdue ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scheme.schemeName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                scheme.durationType.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '• ${scheme.durationCount} Months (${scheme.durationGapDays}d gap)',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor, width: 1),
                        ),
                        child: Text(
                          scheme.status.toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      if (scheme.hasOverdue) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  size: 12, color: Colors.white),
                              SizedBox(width: 3),
                              Text(
                                'OVERDUE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Installment Progress',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${scheme.paidInstallments}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F46E5),
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${scheme.totalInstallments} Paid ',
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '(${(progress * 100).toStringAsFixed(0)}%)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF10B981),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, animatedVal, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: animatedVal,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        animatedVal == 1.0
                            ? const Color(0xFF10B981)
                            : const Color(0xFF4F46E5),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildStatTile(
                    label: 'Installment',
                    value: '₹${scheme.installmentAmount.toStringAsFixed(2)}',
                    bgColor: const Color(0xFFEEF2FF),
                    textColor: const Color(0xFF4338CA),
                  ),
                  _buildStatTile(
                    label: 'Total Amount',
                    value: '₹${scheme.totalAmount.toStringAsFixed(2)}',
                    bgColor: const Color(0xFFF1F5F9),
                    textColor: const Color(0xFF334155),
                  ),
                  _buildStatTile(
                    label: 'Maturity Amt',
                    value: '₹${scheme.maturityAmount.toStringAsFixed(2)}',
                    bgColor: const Color(0xFFE0F2FE),
                    textColor: const Color(0xFF0369A1),
                  ),
                  _buildStatTile(
                    label: 'Total Paid',
                    value: '₹${scheme.totalPaid.toStringAsFixed(2)}',
                    bgColor: const Color(0xFFD1FAE5),
                    textColor: const Color(0xFF047857),
                  ),
                  _buildStatTile(
                    label: 'Balance Due',
                    value: '₹${scheme.balanceDue.toStringAsFixed(2)}',
                    bgColor: scheme.balanceDue > 0
                        ? const Color(0xFFFEE2E2)
                        : const Color(0xFFD1FAE5),
                    textColor: scheme.balanceDue > 0
                        ? const Color(0xFFB91C1C)
                        : const Color(0xFF047857),
                  ),
                  _buildStatTile(
                    label: 'Next Due',
                    value: formatDate(scheme.nextDueDate),
                    bgColor: const Color(0xFFF3E8FF),
                    textColor: const Color(0xFF7E22CE),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.date_range_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Start: ${formatDate(scheme.startDate)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF475569),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'End: ${formatDate(scheme.endDate)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF475569),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (scheme.notes != null && scheme.notes!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.note_alt_outlined,
                        size: 14, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Note: ${scheme.notes}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required String label,
    required String value,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _AnimatedTransactionCard extends StatefulWidget {
  final CustomerTransaction transaction;
  final String Function(String?) formatDate;
  final int index;

  const _AnimatedTransactionCard({
    required this.transaction,
    required this.formatDate,
    required this.index,
  });

  @override
  State<_AnimatedTransactionCard> createState() =>
      _AnimatedTransactionCardState();
}

class _AnimatedTransactionCardState extends State<_AnimatedTransactionCard> {
  bool _isExpanded = false;

  IconData _getPaymentIcon(String mode) {
    switch (mode.toLowerCase()) {
      case 'cash':
        return Icons.money_rounded;
      case 'upi':
        return Icons.qr_code_rounded;
      case 'card':
        return Icons.credit_card_rounded;
      case 'bank':
      case 'neft':
      case 'rtgs':
        return Icons.account_balance_rounded;
      default:
        return Icons.payments_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;
    final closed = tx.paymentsClosed;
    final modeIcon = _getPaymentIcon(tx.paymentMode);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(0, (1 - animValue) * 20),
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(modeIcon,
                            size: 20, color: const Color(0xFF0F172A)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.receiptNo,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.formatDate(tx.paymentDate),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFC7D2FE)),
                    ),
                    child: Text(
                      tx.paymentMode.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF4338CA),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount Received',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹${tx.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Received By',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          tx.receivedBy,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (tx.schemeName != null && tx.schemeName!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.stars_rounded,
                          size: 16, color: Color(0xFF16A34A)),
                      const SizedBox(width: 6),
                      Text(
                        tx.schemeName!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF15803D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (tx.notes != null && tx.notes!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Notes: ${tx.notes}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
              if (closed.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.playlist_add_check_rounded,
                                size: 18, color: Color(0xFF4F46E5)),
                            const SizedBox(width: 6),
                            Text(
                              'Closed Installments (${closed.length})',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                          ],
                        ),
                        AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Column(
                    children: closed.map((item) {
                      final isPaid = item.status.toLowerCase() == 'paid';
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '#${item.installmentNumber}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                          color: Color(0xFF4338CA),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Installment ${item.installmentNumber}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Due: ${widget.formatDate(item.dueDate)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Applied: ₹${item.amountApplied.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: Color(0xFF059669),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: isPaid
                                            ? const Color(0xFFD1FAE5)
                                            : const Color(0xFFFEF3C7),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.status.toUpperCase(),
                                        style: TextStyle(
                                          color: isPaid
                                              ? const Color(0xFF047857)
                                              : const Color(0xFFB45309),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Slot Amt: ₹${item.installmentAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
