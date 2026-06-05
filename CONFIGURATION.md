# Configuration Guide

## 1. API Connection Setup

### Update API Base URL

Edit `lib/services/api_service.dart` and replace the base URL:

```dart
// Before
static const String baseUrl = 'http://localhost:3000';

// After (for production)
static const String baseUrl = 'https://your-erp-api.com';
```

---

## 2. Authentication Flow

The app expects the JWT token to be stored **before** launching the Collection module. Here's how to integrate:

### Step 1: Store Token After Login

In your login endpoint response, save the token:

```dart
// In your login screen/service
final response = await ApiService.loginUser(email, password);
final token = response['token']; // or response['access_token']

// Save it
await ApiService.saveToken(token);

// Navigate to Collection module
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const CustomerListScreen()),
);
```

### Step 2: Add Login Endpoint to ApiService (optional)

```dart
// Add to lib/services/api_service.dart

static Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Login failed');
  }
}
```

---

## 3. API Response Format Compatibility

The app is flexible with API response formats. Map your actual response to these expected formats:

### Customer Object (from any endpoint)
```json
{
  "id": "string",          // or "customer_id"
  "name": "string",
  "phone": "string",
  "email": "string",       // optional
  "address": "string",     // optional
  "total_due": 0,          // or "outstanding_balance"
  "created_at": "ISO8601"  // optional
}
```

### Invoice Object (from ledger)
```json
{
  "id": "string",           // or "invoice_id"
  "customer_id": "string",
  "date": "ISO8601",        // or "invoice_date"
  "items": "string",        // description of items
  "amount": 0,              // or "total_amount"
  "paid_amount": 0,         // or "paid"
  "is_overdue": false,      // computed if missing
  "balance": 0              // or calculate from amount - paid_amount
}
```

### Payment Object (sent to API)
```json
{
  "customer_id": "string",
  "amount": 0,
  "payment_mode": "Cash|UPI|Card",
  "notes": "string"  // optional
}
```

---

## 4. Testing with Mock Data

### Option A: Mock API Service

Create `lib/services/mock_api_service.dart`:

```dart
// For development/testing
class MockApiService {
  static Future<List<dynamic>> getCustomers() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': '1',
        'name': 'Rajesh Kumar',
        'phone': '9876543210',
        'email': 'rajesh@example.com',
        'total_due': 15000,
      },
      {
        'id': '2',
        'name': 'Priya Singh',
        'phone': '9765432109',
        'email': 'priya@example.com',
        'total_due': 8500,
      },
    ];
  }

  static Future<Map<String, dynamic>> getCustomerLedger(String customerId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'invoices': [
        {
          'id': 'INV001',
          'customer_id': customerId,
          'date': DateTime.now().subtract(Duration(days: 40)).toIso8601String(),
          'items': 'Gold Ring - 2g, Bracelet - 5g',
          'amount': 15000,
          'paid_amount': 5000,
          'is_overdue': true,
        },
        {
          'id': 'INV002',
          'customer_id': customerId,
          'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
          'items': 'Silver Necklace - 10g',
          'amount': 8500,
          'paid_amount': 0,
          'is_overdue': false,
        },
      ],
      'total_due': 16500,
    };
  }
}
```

Update `main.dart` to use mock data during development:

```dart
// For testing: import mock service
// import 'services/mock_api_service.dart';

// Then override in ApiService or use conditional logic
```

---

## 5. Token Refresh Strategy

If your JWT tokens expire, implement a refresh mechanism:

```dart
// Add to ApiService
static Future<String?> refreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token');
  
  if (refreshToken == null) return null;

  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/refresh/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh_token': refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newToken = data['access_token'];
    await saveToken(newToken);
    return newToken;
  }
  return null;
}

// Modify API calls to retry with refresh on 401
static Future<T> _makeRequest<T>(
  Future<T> Function(String token) request,
) async {
  try {
    var token = await getToken();
    return await request(token!);
  } on UnauthorizedException {
    token = await refreshToken();
    if (token == null) throw Exception('Session expired');
    return await request(token);
  }
}
```

---

## 6. Payment Mode Mapping

If your backend uses different payment mode values:

```dart
// Map in lib/screens/collect_payment_screen.dart
const Map<String, String> paymentModeMap = {
  'Cash': 'CASH',
  'UPI': 'UPI',
  'Card': 'CREDIT_CARD', // or 'DEBIT_CARD'
};

// Use when sending:
final mode = paymentModeMap[_selectedMode] ?? _selectedMode;
```

---

## 7. Environment Configuration

For multiple environments (dev, staging, prod), create a config file:

`lib/config/app_config.dart`:
```dart
class AppConfig {
  static const String appName = 'Komet Collection';
  
  static String get apiBaseUrl {
    const String env = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    switch (env) {
      case 'prod':
        return 'https://erp-api.komet.in';
      case 'staging':
        return 'https://staging-api.komet.in';
      default:
        return 'http://localhost:3000';
    }
  }
}
```

Run with environment:
```bash
flutter run --dart-define=APP_ENV=prod
```

---

## 8. Permissions (Android/iOS)

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### iOS (Info.plist)
```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app needs internet access to sync payments</string>
<key>NSBonjourServices</key>
<array>
  <string>_http._tcp</string>
</array>
```

---

## 9. Offline Sync Implementation

To enable background sync when reconnected:

```dart
// Add to main.dart or a new service
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineSyncService {
  static final Connectivity _connectivity = Connectivity();

  static void startListening() {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        // User is back online
        await syncPendingPayments();
      }
    });
  }

  static Future<void> syncPendingPayments() async {
    final unsynced = await DatabaseService.getUnsyncedPayments();
    
    for (final payment in unsynced) {
      try {
        await ApiService.recordPayment(
          customerId: payment.customerId,
          amount: payment.amount,
          paymentMode: payment.mode,
          note: payment.note,
        );
        await DatabaseService.markPaymentSynced(payment.id);
      } catch (e) {
        print('Failed to sync payment ${payment.id}: $e');
        // Will retry on next connection check
      }
    }
  }
}
```

Call in `main()`:
```dart
void main() {
  OfflineSyncService.startListening();
  runApp(const KometCollectionApp());
}
```

---

## 10. Error Codes & Handling

Add error codes mapping to user-friendly messages:

```dart
// lib/utils/error_handler.dart
String getErrorMessage(dynamic error) {
  if (error.toString().contains('401')) {
    return 'Session expired. Please log in again.';
  } else if (error.toString().contains('400')) {
    return 'Invalid request. Please check your input.';
  } else if (error.toString().contains('500')) {
    return 'Server error. Please try again later.';
  } else if (error.toString().contains('Network')) {
    return 'No internet connection. Working offline.';
  }
  return 'An error occurred. Please try again.';
}
```

---

## Next Steps

1. Replace `baseUrl` with your actual API endpoint
2. Test API endpoints in Postman/curl before running the app
3. Generate APK/IPA for testing on devices
4. Monitor logs for API errors: `flutter logs`

Happy collecting! 🚀
