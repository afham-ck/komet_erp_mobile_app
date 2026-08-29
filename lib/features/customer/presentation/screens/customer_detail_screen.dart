import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/core/router/app_router.gr.dart';

import 'package:komet_collection/core/widgets/error_tile.dart';

@RoutePage()
class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;
  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  late Customer _customer;
  double _displayTotalDue = 0;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    _displayTotalDue = _customer.totalDue;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerBloc>().add(CustomerEvent.loadLedger(customerId: _customer.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) context.router.pop(_customer);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_customer.name),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<CustomerBloc>().add(CustomerEvent.loadLedger(customerId: _customer.id)),
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state.isLoading && state.invoices.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.totalDue > 0) _displayTotalDue = state.totalDue;

            return Column(
              children: [
                _buildSummaryCard(state),
                if (state.error != null)
                  ErrorTile(
                    message: state.error!,
                    onRetry: () {
                      context.read<CustomerBloc>().add(CustomerEvent.loadLedger(customerId: _customer.id));
                    },
                  ),
                Expanded(child: _buildInvoiceList(state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(CustomerState state) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Due', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    '₹${_displayTotalDue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _displayTotalDue > 0
                          ? theme.colorScheme.error
                          : Colors.green,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_customer.phone, style: theme.textTheme.bodySmall),
                  if (_customer.email != null) ...[
                    const SizedBox(height: 4),
                    Text(_customer.email!, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.router.push(CollectPaymentRoute(customer: _customer)).then((_) {
                  if (mounted) {
                    context.read<CustomerBloc>().add(CustomerEvent.loadLedger(customerId: _customer.id));
                  }
                });
              },
              icon: const Icon(Icons.payment),
              label: const Text('Collect Payment'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(CustomerState state) {
    if (state.invoices.isEmpty) {
      final theme = Theme.of(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text('No invoices', style: theme.textTheme.titleLarge),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CustomerBloc>().add(CustomerEvent.loadLedger(customerId: _customer.id));
      },
      child: ListView.builder(
        itemCount: state.invoices.length,
        itemBuilder: (context, index) {
          final invoice = state.invoices[index];
          return _InvoiceTile(invoice: invoice);
        },
      ),
    );
  }
}

class _InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  const _InvoiceTile({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('d MMM yyyy');
    final backgroundColor = invoice.isOverdue && invoice.balance > 0
        ? theme.colorScheme.errorContainer.withValues(alpha: 0.3)
        : invoice.balance > 0
            ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.3)
            : Colors.green[50];

    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice #${invoice.id}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormat.format(invoice.date),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                if (invoice.isOverdue && invoice.balance > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'OVERDUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              invoice.items,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAmountColumn(theme, 'Amount', '₹${invoice.amount.toStringAsFixed(2)}', null),
                _buildAmountColumn(theme, 'Paid', '₹${invoice.paid.toStringAsFixed(2)}', Colors.green),
                _buildAmountColumn(theme, 'Balance', '₹${invoice.balance.toStringAsFixed(2)}',
                    invoice.balance > 0 ? theme.colorScheme.error : Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountColumn(ThemeData theme, String label, String value, Color? color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
