# Quick Start: E2E Example & Testing Guide

## 1. Setup (5 minutes)

### Prerequisites
- Flutter SDK installed (`flutter doctor` shows no errors)
- A running backend API (or use mock data during development)

### Install & Run

```bash
# Navigate to project
cd komet_erp_mobile_app

# Get dependencies
flutter pub get

# (Optional) Configure API URL
# Edit lib/services/api_service.dart:
# static const String baseUrl = 'https://your-api.com';

# Run app
flutter run
```

---

## 2. Mock Data (For Testing Without Backend)

### Option A: Use Real Backend (Recommended)

If you have a running backend:

1. Update `baseUrl` in `lib/services/api_service.dart`
2. Ensure JWT token is stored (via login screen)
3. Run the app

### Option B: Use Mock API (Development)

Create `lib/services/mock_api_service.dart`:

```dart
import 'package:komet_collection/models/models.dart';

class MockApiService {
  static Future<List<dynamic>> getCustomers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      {
        'id': 'CUST001',
        'name': 'Rajesh Kumar',
        'phone': '9876543210',
        'email': 'rajesh@example.com',
        'address': '123 Main St, Mumbai',
        'total_due': 15000,
        'created_at': DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      },
      {
        'id': 'CUST002',
        'name': 'Priya Singh',
        'phone': '9765432109',
        'email': 'priya@example.com',
        'total_due': 8500,
      },
      {
        'id': 'CUST003',
        'name': 'Amit Patel',
        'phone': '9654321098',
        'total_due': 0, // Paid in full
      },
    ];
  }

  static Future<Map<String, dynamic>> getCustomerLedger(String customerId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Different data based on customer ID
    if (customerId == 'CUST001') {
      return {
        'invoices': [
          {
            'id': 'INV001',
            'date': DateTime.now().subtract(Duration(days: 40)).toIso8601String(),
            'items': 'Gold Ring - 2g, Bracelet - 5g',
            'amount': 15000,
            'paid_amount': 5000,
            'is_overdue': true,
          },
          {
            'id': 'INV002',
            'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
            'items': 'Silver Necklace - 10g',
            'amount': 8500,
            'paid_amount': 0,
            'is_overdue': false,
          },
        ],
        'total_due': 16500,
      };
    } else if (customerId == 'CUST002') {
      return {
        'invoices': [
          {
            'id': 'INV003',
            'date': DateTime.now().subtract(Duration(days: 10)).toIso8601String(),
            'items': 'Diamond Earrings - 0.5ct',
            'amount': 8500,
            'paid_amount': 0,
            'is_overdue': false,
          },
        ],
        'total_due': 8500,
      };
    } else {
      return {
        'invoices': [
          {
            'id': 'INV004',
            'date': DateTime.now().subtract(Duration(days: 60)).toIso8601String(),
            'items': 'Pearl Necklace',
            'amount': 5000,
            'paid_amount': 5000,
            'is_overdue': false,
          },
        ],
        'total_due': 0,
      };
    }
  }

  static Future<Map<String, dynamic>> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'id': 'CUST${DateTime.now().millisecondsSinceEpoch}',
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'total_due': 0,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  static Future<Map<String, dynamic>> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'payment_id': 'PAY${DateTime.now().millisecondsSinceEpoch}',
      'customer_id': customerId,
      'amount': amount,
      'payment_mode': paymentMode,
      'balance_remaining': 5000, // Example
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
```

To use mock service, update `lib/services/api_service.dart`:

```dart
// At the top, comment out real service and import mock
// import 'api_service.dart';
import 'mock_api_service.dart' as api;

// Then replace all ApiService calls with:
// await api.MockApiService.getCustomers();
// ... etc
```

---

## 3. Test Scenarios

### Test 1: Customer List & Search

**Steps:**
1. Launch app → See customer list (sorted by balance)
2. Tap search bar → Type "rajesh" → See filtered list
3. Clear search → See full list again

**Expected Results:**
- ✅ Customers sorted by `total_due DESC`
- ✅ Search filters by name or phone in real-time
- ✅ Clear button resets search

**Debug Tips:**
```dart
// In customer_list_screen.dart, check _filteredCustomers list
print('Customers: ${_filteredCustomers.map((c) => '${c.name}: ${c.totalDue}').toList()}');
```

---

### Test 2: Customer Detail & Overdue Highlighting

**Steps:**
1. From list, tap "Rajesh Kumar" → See ledger
2. Look for invoices with red "OVERDUE" badge (INV001, 40+ days old)
3. See balance breakdown (amount, paid, balance)

**Expected Results:**
- ✅ Invoices sorted by date DESC
- ✅ Overdue badge only on invoices with balance > 0 AND date > 30 days ago
- ✅ Red text for balance due, green for paid

**Debug Tips:**
```dart
// Check overdue calculation in models.dart
print('Is overdue: ${invoice.isOverdue}');
print('Days old: ${DateTime.now().difference(invoice.date).inDays}');
```

---

### Test 3: Quick Payment Collection

**Steps:**
1. From ledger, tap "COLLECT PAYMENT"
2. Enter amount: 5000
3. Select mode: "UPI"
4. Add note: "Partial payment"
5. Tap "CONFIRM PAYMENT"

**Expected Results:**
- ✅ Form validates amount (> 0, numeric)
- ✅ Payment mode toggles (Cash/UPI/Card)
- ✅ Success message appears
- ✅ Auto-returns to ledger after 2 seconds
- ✅ Payment recorded in database

**Debug Tips:**
```dart
// Check payment saved locally
final unsynced = await DatabaseService.getUnsyncedPayments();
print('Unsynced payments: ${unsynced.length}');
```

---

### Test 4: Add Customer (with Advanced Fields)

**Steps:**
1. From list, tap FAB "Add Customer"
2. Enter name: "John Doe"
3. Enter phone: "9999999999"
4. Tap "Advanced Information" to expand
5. Enter email: "john@example.com"
6. Enter address: "456 Park Ave"
7. Tap "ADD CUSTOMER"

**Expected Results:**
- ✅ Name + phone mandatory (error if missing)
- ✅ Advanced section collapses/expands
- ✅ Optional fields don't block form submission
- ✅ Success message → returns to list
- ✅ New customer visible in list

**Debug Tips:**
```dart
// Check customer saved
final all = await DatabaseService.getAllCustomers();
print('Total customers: ${all.length}');
```

---

### Test 5: Offline Mode

**Steps:**
1. Enable airplane mode (or kill API)
2. Force refresh in list screen
3. See "Offline mode: Cached data" banner
4. Try to search → works (using cached data)
5. Add customer → "Saved offline" message
6. Record payment → "Saved offline" message
7. Disable airplane mode → payments auto-sync

**Expected Results:**
- ✅ Cache used when API unavailable
- ✅ Offline banner shows
- ✅ Search works on cached data
- ✅ Payments stored locally (`synced=0`)
- ✅ On reconnection, auto-sync (optional)

**Debug Tips:**
```dart
// Check cache
final cached = await DatabaseService.getAllCustomers();
print('Cached customers: ${cached.length}');

// Check unsynced payments
final unsynced = await DatabaseService.getUnsyncedPayments();
print('Pending sync: ${unsynced.length}');
```

---

### Test 6: Data Persistence

**Steps:**
1. Add a customer while offline
2. Close app (fully terminate)
3. Reopen app
4. Check customer list → still see new customer

**Expected Results:**
- ✅ Data persists in SQLite
- ✅ New customer visible even after app restart

**Debug Tips:**
```dart
// SQLite queries
final db = await DatabaseService.db;
final maps = await db.query('customers');
print('Customers in DB: ${maps.length}');
```

---

## 4. API Integration Testing (With Real Backend)

### Setup

1. **Get JWT Token**

```bash
# Example login endpoint
curl -X POST http://your-api.com/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"email":"staff@example.com","password":"password123"}'

# Response:
# { "token": "eyJhbGciOiJIUzI1NiIs..." }
```

2. **Store Token in App**

In your login screen, after getting token:

```dart
await ApiService.saveToken(token);
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const CustomerListScreen()),
);
```

3. **Update API Base URL**

```dart
// lib/services/api_service.dart
static const String baseUrl = 'https://your-erp-api.com';
```

### Test Each Endpoint

#### 1. Get Customers

```bash
curl -X GET http://your-api.com/api/customers/ \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..."
```

#### 2. Get Customer Ledger

```bash
curl -X POST http://your-api.com/api/billing/invoices/customer_ledger/ \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{"customer_id":"CUST001"}'
```

#### 3. Create Customer

```bash
curl -X POST http://your-api.com/api/billing/create-customer/ \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "name":"Test Customer",
    "phone":"9876543210",
    "email":"test@example.com",
    "address":"123 Test St"
  }'
```

#### 4. Record Payment

```bash
curl -X POST http://your-api.com/api/billing/record-payment/ \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "customer_id":"CUST001",
    "amount":5000,
    "payment_mode":"Cash",
    "notes":"Test payment"
  }'
```

---

## 5. Performance Testing

### Cold Start (First Launch)
```bash
flutter run --profile
# Check: Time to show list should be < 2 seconds
```

### Search Performance
- Type slowly → Should filter instantly (< 100ms)
- Type "rajesh" → Should filter 1000+ customers in < 200ms

### Offline Mode
- Kill API → Should show cached data in < 500ms

---

## 6. Common Issues & Fixes

### Issue: "No token found" error
**Solution**: Ensure token is stored before navigating to this screen
```dart
await ApiService.saveToken(token);
```

### Issue: Payments not syncing
**Solution**: Check unsynced count
```dart
final unsynced = await DatabaseService.getUnsyncedPayments();
print('Waiting to sync: ${unsynced.length}');
```

### Issue: "Socket exception" when API unavailable
**Solution**: Should fall back to cache + show offline banner
- Check that `DatabaseService.getUnsyncedPayments()` is called
- Verify offline banner is displayed

### Issue: Incorrect date formatting
**Solution**: Check `intl` package initialization
```dart
import 'package:intl/intl.dart';
final format = DateFormat('d MMM yyyy');
```

---

## 7. Build & Release

### Android APK

```bash
# Debug APK (for testing)
flutter build apk --debug

# Release APK (for production)
flutter build apk --release

# Find APK at: build/app/outputs/flutter-apk/app-release.apk
```

### iOS IPA

```bash
# Release build
flutter build ios --release

# Archive & distribute via TestFlight/App Store
```

### Code Analysis

```bash
# Check for issues
flutter analyze

# Format code
dart format lib/
```

---

## 8. Next Steps

1. ✅ Test with mock data locally
2. ✅ Set up real backend API endpoints
3. ✅ Update API base URL
4. ✅ Test all 4 endpoints with Postman
5. ✅ Test with real JWT token
6. ✅ Run through all 6 test scenarios
7. ✅ Test offline mode (airplane mode)
8. ✅ Build APK/IPA
9. ✅ Deploy to test devices
10. ✅ Collect feedback & iterate

---

**Happy testing! 🎉**
