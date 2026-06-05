# Architecture Overview

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Flutter Mobile App                          │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │                     Presentation Layer                         │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │ │
│  │  │Customer List │  │Customer Detail│  │ Payment Collection  │ │ │
│  │  │   Screen     │  │   Screen      │  │    & Add Customer   │ │ │
│  │  └──────────────┘  └──────────────┘  └──────────────────────┘ │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │                   Business Logic Layer                         │ │
│  │  ┌────────────────────────────────────────────────────────┐   │ │
│  │  │              State Management                          │   │ │
│  │  │  (Stateful Widgets + Provider ready)                 │   │ │
│  │  └────────────────────────────────────────────────────────┘   │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │                     Services Layer                             │ │
│  │  ┌──────────────┐              ┌──────────────────────────┐   │ │
│  │  │ API Service  │              │ Database Service         │   │ │
│  │  │ • HTTP calls │◄────────────►│ • SQLite operations      │   │ │
│  │  │ • JWT auth   │              │ • Local caching          │   │ │
│  │  │ • Token mgmt │              │ • Offline storage        │   │ │
│  │  └──────────────┘              └──────────────────────────┘   │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │                    Data Models Layer                           │ │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐                    │ │
│  │  │Customer  │  │ Invoice  │  │ Payment  │                    │ │
│  │  │ • name   │  │ • date   │  │ • amount │                    │ │
│  │  │ • phone  │  │ • amount │  │ • mode   │                    │ │
│  │  │ • due    │  │ • paid   │  │ • date   │                    │ │
│  │  └──────────┘  └──────────┘  └──────────┘                    │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
         │                                        │
         │                                        │
         ▼                                        ▼
    ┌─────────────┐                      ┌──────────────────┐
    │ Backend API │                      │ SQLite Database  │
    │ (REST/JWT)  │                      │ (Local Cache)    │
    └─────────────┘                      └──────────────────┘
```

---

## Data Flow Diagram

### Scenario 1: Fetch Customer List (Online)

```
User opens app
       │
       ▼
[CustomerListScreen.initState()]
       │
       ├─► [ApiService.getCustomers()] ◄─── HTTP GET /api/customers/
       │                                        │
       │                                        ▼
       │                                    Backend API
       │                                        │
       ├─ Response received ◄───────────────────┘
       │
       ├─► [DatabaseService.insertCustomers()] ◄─ Cache to SQLite
       │
       ├─► setState() ◄─ UI refreshes with sorted list
       │
       ▼
Show list sorted by balance DESC
```

### Scenario 2: Fetch Customer List (Offline)

```
User opens app / Refreshes
       │
       ├─► [ApiService.getCustomers()] ◄─── HTTP GET /api/customers/
       │                                        │
       │                                    Network Error ✗
       │                                        │
       ├─ Exception caught ◄──────────────────┘
       │
       ├─► [DatabaseService.getAllCustomers()] ◄─ Load from SQLite
       │
       ├─► Show offline banner ◄─ UI refreshes with cached data
       │
       ▼
Show cached list + "Offline mode" banner
```

### Scenario 3: Record Payment (Online)

```
User fills payment form
       │
       ├─ Validate (amount > 0, mode selected)
       │
       ├─► [ApiService.recordPayment()] ◄─── HTTP POST /api/billing/record-payment/
       │                                           │
       │                                           ▼
       │                                       Backend API
       │                                           │
       ├─ Response received ✓ ◄────────────────────┘
       │
       ├─► [DatabaseService.insertPayment(paymentId)] ◄─ Cache as "synced"
       │
       ├─► Show success message
       │
       ├─► Auto-return to detail
       │
       ▼
Ledger refreshed, balance updated
```

### Scenario 4: Record Payment (Offline)

```
User fills payment form
       │
       ├─ Validate (amount > 0, mode selected)
       │
       ├─► [ApiService.recordPayment()] ◄─── HTTP POST /api/billing/record-payment/
       │                                           │
       │                                    Network Error ✗
       │                                           │
       ├─ Exception caught ◄───────────────────────┘
       │
       ├─► [DatabaseService.insertPayment()] ◄─ Cache as "synced=0" (pending)
       │
       ├─► Show "Saved offline. Will sync when connected"
       │
       ├─► Auto-return to detail
       │
       ▼
Payment stored locally, synced when reconnected
```

---

## Component Interaction Map

### ApiService → Database Sync

```
┌─────────────────────────┐
│   API Response          │
│ ┌───────────────────┐   │
│ │ invoices: [...]   │   │
│ │ total_due: 10000  │   │
│ └───────────────────┘   │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────────────┐
│   Parse to Model                │
│ Invoice.fromJson(json)          │
│ Customer.fromJson(json)         │
│ Payment.fromJson(json)          │
└────────────┬────────────────────┘
             │
             ▼
┌──────────────────────────────────┐
│   DatabaseService CRUD           │
│ • insertInvoices()               │
│ • insertCustomers()              │
│ • insertPayment()                │
│ • getAllCustomers()              │
│ • getCustomerInvoices()          │
│ • getUnsyncedPayments()          │
└──────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────┐
│   SQLite Database                │
│ [customers]  [invoices] [payments]
└──────────────────────────────────┘
```

---

## Error Handling Flow

```
API/Database Operation
       │
       ├─ Success (200, 201)
       │     │
       │     ├─► Parse response
       │     │
       │     ├─► Cache to SQLite
       │     │
       │     └─► Return to UI
       │
       └─ Error (4xx, 5xx, Network)
             │
             ├─► Try from SQLite cache
             │
             ├─ Cache available
             │     │
             │     ├─► Show cached data
             │     │
             │     └─► Show offline banner
             │
             └─ Cache empty
                   │
                   └─► Show error message
```

---

## Authentication & Token Flow

```
1. User Login (in parent app)
   ┌──────────────────┐
   │ Login Screen     │
   │ Enter email/pwd  │
   └────────┬─────────┘
            │
            ▼
   ┌──────────────────────────┐
   │ Backend /api/auth/login  │
   │ Response: {token: "xxx"} │
   └────────┬─────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ ApiService.saveToken(token)  │
   │ Stored in SharedPreferences  │
   └────────┬─────────────────────┘
            │
            ▼
   Navigate to Collection module
   
2. Collection Module Usage
   ┌──────────────────────────────┐
   │ Any API call                 │
   └────────┬─────────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ ApiService.getToken()        │
   │ Retrieved from prefs         │
   └────────┬─────────────────────┘
            │
            ▼
   ┌──────────────────────────────────────────┐
   │ HTTP request with Authorization header   │
   │ "Authorization: Bearer {token}"          │
   └──────────────────────────────────────────┘
```

---

## Database Schema

```sql
-- Customers Table
CREATE TABLE customers (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  address TEXT,
  total_due REAL DEFAULT 0,
  created_at TEXT,
  synced_at TEXT            -- Last sync timestamp
);

-- Invoices Table
CREATE TABLE invoices (
  id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  date TEXT NOT NULL,
  items TEXT,
  amount REAL NOT NULL,
  paid REAL DEFAULT 0,
  balance REAL NOT NULL,
  is_overdue INTEGER DEFAULT 0,
  FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Payments Table (Sync Queue)
CREATE TABLE payments (
  id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  amount REAL NOT NULL,
  mode TEXT NOT NULL,
  date TEXT NOT NULL,
  note TEXT,
  synced INTEGER DEFAULT 0,    -- 0 = pending, 1 = synced
  FOREIGN KEY(customer_id) REFERENCES customers(id)
);
```

---

## State Management Architecture

### Current: Stateful Widgets (Simple)

```
┌─────────────────────────────┐
│   Stateful Screen           │
│  ┌─────────────────────┐    │
│  │ initState()         │    │
│  │ • Load from API     │    │
│  │ • Catch exceptions  │    │
│  │ • set state         │    │
│  └─────────────────────┘    │
│                             │
│  ┌─────────────────────┐    │
│  │ build()             │    │
│  │ • Render UI         │    │
│  │ • Listen to events  │    │
│  └─────────────────────┘    │
│                             │
│  ┌─────────────────────┐    │
│  │ dispose()           │    │
│  │ • Cleanup           │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```

### Future: Provider Pattern (Scalable)

```
┌─────────────────────────────────────┐
│ StateNotifier (Provider pattern)    │
│ ┌─────────────────────────────────┐ │
│ │ class CustomerProvider extends  │ │
│ │   StateNotifier<List<Customer>> │ │
│ │                                 │ │
│ │ • loadCustomers()               │ │
│ │ • searchCustomers()             │ │
│ │ • addCustomer()                 │ │
│ └─────────────────────────────────┘ │
│              │                       │
│              ▼                       │
│ ┌─────────────────────────────────┐ │
│ │ Widgets consume via:            │ │
│ │ ref.watch(customerProvider)     │ │
│ │ ref.read(customerProvider)      │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

---

## API Integration Points

```
┌────────────────────────────────────┐
│         App Screens                │
└────────┬─────────────────────────┬─┘
         │                         │
         ▼                         ▼
┌──────────────────────┐  ┌──────────────────────┐
│ Customer List Screen │  │ Customer Detail Scr. │
│ • getCustomers()     │  │ • getCustomerLedger()
└──────────────────────┘  └──────────────────────┘
         │                         │
         ├─────────────┬───────────┤
         │             │           │
         ▼             ▼           ▼
┌────────────────────────────────────────┐
│     ApiService (Centralized)           │
│ ┌──────────────────────────────────┐   │
│ │ GET /api/customers/              │   │
│ │ POST /api/billing/invoices/      │   │
│ │       customer_ledger/           │   │
│ │ POST /api/billing/record-payment/│   │
│ │ POST /api/billing/create-customer│   │
│ └──────────────────────────────────┘   │
└──────────┬───────────────────────────┬─┘
           │                           │
    ┌──────▼──────┐          ┌─────────▼────────┐
    │ HTTP Client │          │ Token Manager    │
    │ (http pkg)  │          │ (SharedPrefs)    │
    └──────┬──────┘          └─────────┬────────┘
           │                           │
           └───────────┬───────────────┘
                       │
                       ▼
           ┌───────────────────────┐
           │   Backend REST API    │
           │   (Jewelry ERP)       │
           └───────────────────────┘
```

---

## Offline Sync Strategy

```
┌────────────────────────────────────────────────┐
│  Offline Payment Recording                     │
│                                                │
│  1. User records payment (no connection)       │
│     ├─► Payment saved to SQLite                │
│     │   (synced = 0)                           │
│     └─► UI shows "Saved offline" message      │
│                                                │
│  2. Connection restored                        │
│     ├─► (Optional) Background sync service    │
│     │   or manual refresh                      │
│     │                                           │
│     └─► getUnsyncedPayments() called           │
│         ├─► For each payment:                  │
│         │   ├─► ApiService.recordPayment()    │
│         │   └─► markPaymentSynced()           │
│         │                                      │
│         └─► All payments synced                │
│             (synced = 1)                       │
│                                                │
│  3. Result                                     │
│     ├─ Success: Payment recorded on server    │
│     └─ Failure: Retry on next connection      │
│                                                │
└────────────────────────────────────────────────┘
```

---

## Deployment Architecture

```
┌──────────────────────────────────┐
│   Flutter App                    │
│  (iOS IPA / Android APK)         │
└────────┬─────────────────────────┘
         │
    ┌────▼────────────┐
    │ Device Storage  │
    │ • JWT token     │
    │ • Customer cache│
    │ • Payments Q    │
    │ • Invoices      │
    └─────────────────┘
         │
    ┌────▼────────────────────────────┐
    │  Network                        │
    │  (WiFi / Cellular)              │
    └────┬───────────────────────────┘
         │
    ┌────▼────────────────────────────┐
    │  Backend API (Jewelry ERP)      │
    │  • Authentication               │
    │  • Customer Management          │
    │  • Invoice/Ledger               │
    │  • Payment Recording            │
    └─────────────────────────────────┘
         │
         ▼
    ┌──────────────────────────────────┐
    │  Database (PostgreSQL/MySQL)     │
    │  • Customers                     │
    │  • Invoices                      │
    │  • Payments                      │
    │  • Ledger                        │
    └──────────────────────────────────┘
```

---

## Summary

- **Layered Architecture**: Presentation → Business → Services → Data
- **Offline-First**: Cache-on-read pattern with sync queue
- **Model-Driven**: Strong typing with Customer, Invoice, Payment models
- **Centralized API**: All HTTP calls via ApiService
- **Persistent Storage**: SQLite for offline capability
- **Token-Based Auth**: JWT stored locally, sent in all API requests
- **Scalable**: Ready for Provider pattern upgrade

---

End of Architecture Document
