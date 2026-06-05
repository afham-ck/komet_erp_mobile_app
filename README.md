# Komet Collection - Mobile Payment Collection Module

A simplified Flutter-based mobile payment collection app for jewelry ERP store staff to track and collect customer payments on the go.

## Features

### 1. **Customer List (Home Screen)**
- Searchable customer list sorted by **outstanding balance (highest first)**
- Displays: Customer name, phone number, and total due amount
- Pull-to-refresh to sync latest customer data
- FAB to add new customers
- **Offline support**: Last-seen customer list cached locally

### 2. **Customer Ledger (Detail Screen)**
- View complete invoice history for selected customer
- Shows: Invoice date, items, amount, paid amount, and balance
- **Overdue highlighting**: Red badge for invoices overdue by 30+ days
- Prominent "Collect Payment" button
- Real-time balance display

### 3. **Quick Payment Collection**
- Simple form with:
  - **Amount** field (numeric input)
  - **Payment Mode**: Cash / UPI / Card (segmented selector)
  - **Optional note** for reference
- One-tap confirmation
- Offline-capable: Saves locally when connection unavailable
- **Auto-sync**: Payments synced to server when back online

### 4. **Add Customer**
- **Mandatory fields**: Name, Phone
- **Collapsible advanced section**: Email, Address (optional)
- Minimal, fast data entry
- Works offline (syncs when connected)

---

## Architecture

### Directory Structure
```
lib/
├── main.dart                          # App entry point
├── services/
│   └── api_service.dart              # HTTP API calls + JWT token management
├── models/
│   └── models.dart                   # Customer, Invoice, Payment data models
├── database/
│   └── database_service.dart         # SQLite local caching
└── screens/
    ├── customer_list_screen.dart     # Search + sorted list
    ├── customer_detail_screen.dart   # Ledger view
    ├── collect_payment_screen.dart   # Payment form
    └── add_customer_screen.dart      # New customer form
```

### Key Technologies
- **Flutter**: Cross-platform mobile UI framework
- **SQLite** (sqflite): Local database for offline caching
- **HTTP**: RESTful API communication
- **JWT**: Token-based authentication
- **Provider**: State management (configured for future expansion)
- **Intl**: Date/time formatting

---

## API Integration

### Authentication
- Token stored locally in `SharedPreferences` after login
- All API requests include `Authorization: Bearer {token}` header

### Endpoints Used

#### 1. **Fetch Customer Ledger**
```
POST /api/billing/invoices/customer_ledger/
Headers: Authorization: Bearer {token}
Body: { "customer_id": "xxx" }

Response:
{
  "invoices": [
    {
      "id": "INV001",
      "date": "2024-06-01T00:00:00",
      "items": "Gold Ring - 2g",
      "amount": 5000,
      "paid_amount": 2000,
      "is_overdue": true
    }
  ],
  "total_due": 3000
}
```

#### 2. **Create Customer**
```
POST /api/billing/create-customer/
Headers: Authorization: Bearer {token}
Body: {
  "name": "Rajesh Kumar",
  "phone": "9876543210",
  "email": "rajesh@example.com" (optional),
  "address": "123 Main St" (optional)
}

Response:
{
  "id": "CUST001",
  "name": "Rajesh Kumar",
  "phone": "9876543210",
  "total_due": 0
}
```

#### 3. **Record Payment**
```
POST /api/billing/record-payment/
Headers: Authorization: Bearer {token}
Body: {
  "customer_id": "CUST001",
  "amount": 5000,
  "payment_mode": "Cash",
  "notes": "Partial payment - INV001" (optional)
}

Response:
{
  "payment_id": "PAY001",
  "customer_id": "CUST001",
  "amount": 5000,
  "balance_remaining": 3000
}
```

#### 4. **Get All Customers** (optional, for initial sync)
```
GET /api/customers/?offset=0&limit=50
Headers: Authorization: Bearer {token}

Response:
{
  "results": [
    {
      "id": "CUST001",
      "name": "Rajesh Kumar",
      "phone": "9876543210",
      "outstanding_balance": 3000
    }
  ]
}
```

---

## Offline Capability

### How It Works
1. **On First Launch**: 
   - App fetches customer list from API → caches to SQLite
   - All subsequent launches load from cache first (UX: fast startup)
   - Refresh button syncs latest data from API

2. **Customer List Screen**:
   - If API call fails → shows cached customers + "Offline mode" banner
   - Search works on cached data

3. **Payment Recording**:
   - Online: Payment sent to API immediately → synced locally
   - Offline: Payment saved locally (marked `synced=0`)
   - Auto-sync: On reconnection, unsynced payments are retried

4. **Data Sync Strategy**:
   - Customers: Overwritten on each refresh (simple, non-conflicting)
   - Payments: Local queue → synced via retry logic when online

---

## Setup Instructions

### Prerequisites
- Flutter SDK 3.0+
- Android SDK (API 21+) or iOS 12+
- Backend API running with JWT auth endpoint

### Installation

1. **Clone repository**
   ```bash
   git clone <repo-url>
   cd komet_erp_mobile_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API URL** (in `lib/services/api_service.dart`)
   ```dart
   static const String baseUrl = 'https://your-api-domain.com';
   ```

4. **Run app**
   ```bash
   flutter run
   ```

### Build

**Android APK**
```bash
flutter build apk --release
```

**iOS IPA**
```bash
flutter build ios --release
```

---

## User Flows

### Flow 1: Collect Payment
1. Home Screen → Tap customer → Customer Detail
2. Tap "Collect Payment" → Payment Form
3. Enter amount + select mode (Cash/UPI/Card) + optional note
4. Confirm → Payment recorded → Return to detail screen

### Flow 2: Add New Customer
1. Home Screen → Tap FAB "Add Customer"
2. Fill mandatory fields (Name, Phone)
3. (Optional) Expand "Advanced" → add email/address
4. Tap "Add Customer" → Confirm → Return to home

### Flow 3: Search Customers
1. Home Screen → Type in search bar (name or phone)
2. List updates in real-time
3. Tap to view ledger

---

## Error Handling

- **No Token**: Redirects to login (implement auth screen separately)
- **API Failure**: Shows cached data with "Offline mode" banner
- **Invalid Input**: Client-side validation with error messages
- **Payment Sync**: Unsynced payments stored locally, retried on reconnection

---

## Future Enhancements

1. **Payment History** screen with filters (date, mode, status)
2. **Bulk SMS/WhatsApp** to customers with overdue invoices
3. **Receipt generation** (PDF/image)
4. **Biometric authentication** for payments
5. **Expense tracking** (petty cash, staff advances)
6. **Analytics dashboard** (daily/weekly collections)
7. **Multi-language support** (Hindi, Tamil, etc.)

---

## Configuration

### SharedPreferences Keys
- `jwt_token`: Stores JWT token from login endpoint

### SQLite Tables
- `customers`: Cached customer list
- `invoices`: Cached invoice ledger
- `payments`: Local payment queue (synced when online)

---

## Dependencies

| Package | Purpose |
|---------|---------|
| `http` | REST API calls |
| `sqflite` | Local SQLite database |
| `shared_preferences` | Token storage |
| `intl` | Date formatting |
| `uuid` | Unique payment IDs |
| `connectivity_plus` | Online/offline detection |
| `provider` | State management (optional) |

---

## Notes

- **No Authentication UI**: This module assumes JWT token is already stored (login done in parent app)
- **Single outlet mode**: Optimized for one store location per login
- **Numeric-only balances**: Simplifies calculation; no fractional currency support
- **Cash-preferred UI**: "Cash" mode is default payment method

---

## Support & Issues

For bugs or feature requests, contact: support@komet.com
