import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_event.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_state.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/core/router/app_router.gr.dart';

@RoutePage()
class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Customer> _filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerBloc>().add(const CustomerEvent.loadCustomers());
    });
  }

  void _filterCustomers(String query, List<Customer> customers) {
    setState(() {
      if (query.isEmpty) {
        _filteredCustomers = customers;
      } else {
        _filteredCustomers = customers.where((c) =>
          c.name.toLowerCase().contains(query.toLowerCase()) ||
          c.phone.contains(query),
        ).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            context.router.replaceAll([const LoginRoute()]);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Collection'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<CustomerBloc>().add(const CustomerEvent.loadCustomers()),
              tooltip: 'Refresh',
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.logout());
              },
              tooltip: 'Logout',
            ),
          ],
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state.isLoading && state.customers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Sync filtered list on data change or search query changes
            final customers = state.customers;
            if (_filteredCustomers.isEmpty && _searchController.text.isEmpty) {
              _filteredCustomers = customers;
            } else if (_searchController.text.isNotEmpty) {
              // Ensure filtered list is computed based on latest customers
              _filteredCustomers = customers.where((c) =>
                c.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                c.phone.contains(_searchController.text),
              ).toList();
            } else {
              _filteredCustomers = customers;
            }

            return Column(
              children: [
                _buildSearchBar(customers),
                if (state.error != null && state.customers.isEmpty)
                  _buildErrorBanner(state.error!),
                Expanded(
                  child: _filteredCustomers.isEmpty
                      ? _buildEmptyState()
                      : _buildCustomerList(),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final router = context.router;
            final bloc = context.read<CustomerBloc>();
            router.push(const AddCustomerRoute()).then((_) {
              if (mounted) {
                bloc.add(const CustomerEvent.loadCustomers());
              }
            });
          },
          icon: const Icon(Icons.person_add),
          label: const Text('Add Customer'),
        ),
      ),
    );
  }

  Widget _buildSearchBar(List<Customer> customers) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by name or phone',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterCustomers('', customers);
                  },
                )
              : null,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        onChanged: (query) {
          _filterCustomers(query, customers);
        },
      ),
    );
  }

  Widget _buildErrorBanner(String message) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: theme.colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(Icons.error, color: theme.colorScheme.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: theme.colorScheme.onErrorContainer,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty ? 'No customers yet' : 'No matching customers',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CustomerBloc>().add(const CustomerEvent.loadCustomers());
      },
      child: ListView.builder(
        itemCount: _filteredCustomers.length,
        itemBuilder: (context, index) {
          final customer = _filteredCustomers[index];
          return _CustomerTile(
            customer: customer,
            onTap: () {
              final router = context.router;
              final bloc = context.read<CustomerBloc>();
              router.push(CustomerDetailRoute(customer: customer)).then((_) {
                if (mounted) {
                  bloc.add(const CustomerEvent.loadCustomers());
                }
              });
            },
          );
        },
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  final Customer customer;
  final VoidCallback onTap;

  const _CustomerTile({required this.customer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            customer.name[0].toUpperCase(),
            style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(customer.phone),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${customer.totalDue.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: customer.totalDue > 0
                    ? theme.colorScheme.error
                    : Colors.green,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text('Due', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
