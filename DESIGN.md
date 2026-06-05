# Komet Collection - Design & UI/UX Document

## Visual Design System

### Color Palette
| Color | Usage | Hex |
|-------|-------|-----|
| Deep Purple | Primary brand, buttons, highlights | #6F42C1 |
| Purple Light | Card backgrounds, disabled states | #E8D4F8 |
| Red | Alert, overdue, balance due | #DC3545 |
| Green | Success, paid, positive balance | #28A745 |
| Orange | Warnings, offline mode | #FFC107 |
| Grey 100 | Input backgrounds | #F3F3F3 |
| Grey 300 | Dividers, disabled text | #D3D3D3 |

### Typography
- **Headings**: Bold, 18-20pt (titles), 16pt (section headers)
- **Body Text**: Regular, 14pt
- **Caption**: Regular, 12pt (secondary info)
- **Buttons**: Bold, 16pt

---

## Screen 1: Customer List (Home)

### Layout
```
┌─────────────────────────────┐
│ Collection          ↻ Logout│  ← App Bar
├─────────────────────────────┤
│ [Search by name/phone...] ✕│  ← Search Bar
├─────────────────────────────┤
│ ⚠️ Offline mode: Cached data│  ← Info banner (if offline)
├─────────────────────────────┤
│ ┌───────────────────────────┐│
│ │ 👤 Rajesh Kumar          ││
│ │    9876543210            ││
│ │                 ₹15,000  ││  ← Customer tile (sorted by balance desc)
│ │                  Due     ││
│ └───────────────────────────┘│
│                              │
│ ┌───────────────────────────┐│
│ │ 👤 Priya Singh           ││
│ │    9765432109            ││
│ │                  ₹8,500  ││
│ │                   Due    ││
│ └───────────────────────────┘│
│                              │
│ ┌───────────────────────────┐│
│ │ 👤 Amit Patel            ││
│ │    9654321098            ││
│ │                     ₹0   ││
│ │                   Paid   ││  ← Green when balance = 0
│ └───────────────────────────┘│
│                              │
│                              │
├─────────────────────────────┤
│                    [+ Add Customer] │  ← FAB
└─────────────────────────────┘
```

### Interactions
- **Tap Customer Tile**: Navigate to Customer Detail
- **Search**: Real-time filter by name or phone
- **FAB**: Open Add Customer screen
- **Refresh Button**: Sync latest customer data
- **Pull-to-Refresh**: (Optional) Swipe down to refresh

### States
- **Empty State**: Shows icon + "No customers yet" when no data
- **Loading State**: Spinner in center
- **Offline State**: Info banner + cached data
- **Search No Results**: Shows icon + "No matching customers"

---

## Screen 2: Customer Ledger / Detail

### Layout
```
┌─────────────────────────────┐
│ Rajesh Kumar            ↻    │  ← App Bar (customer name)
├─────────────────────────────┤
│ Total Due                    │  ← Header section (deep purple bg)
│ ₹16,500                      │
│ 9876543210 | rajesh@ex...  │
│                              │
│ ┌─────────────────────────┐ │
│ │ COLLECT PAYMENT         │ │  ← Big CTA button
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ Invoice #INV001              │
│ 1 Jun 2024 │ OVERDUE (red)   │  ← Invoice card (sorted by date desc)
│ Gold Ring - 2g, Bracelet...  │
│                              │
│ Amount: ₹15,000   Paid: ₹5,000│
│ Balance: ₹10,000 (red text)  │
│                              │
├─────────────────────────────┤
│ Invoice #INV002              │
│ 28 May 2024                  │  ← Normal invoice
│ Silver Necklace - 10g        │
│                              │
│ Amount: ₹8,500    Paid: ₹0   │
│ Balance: ₹8,500 (red text)   │
├─────────────────────────────┤
│ Invoice #INV003              │
│ 15 May 2024                  │
│ Diamond Earrings - 0.5ct    │
│                              │
│ Amount: ₹22,000   Paid: ₹22,000│
│ Balance: ₹0 (green text)     │  ← Paid invoice
├─────────────────────────────┤
│                              │
└─────────────────────────────┘
```

### Interactions
- **Collect Payment Button**: Navigate to payment form
- **Back**: Return to customer list (list refreshes on return)
- **Refresh Button**: Reload ledger from API

### Color Coding
- **Overdue Invoice**: Red header + "OVERDUE" badge
- **Pending Invoice**: Yellow/orange header
- **Paid Invoice**: Green header

---

## Screen 3: Collect Payment Form

### Layout
```
┌─────────────────────────────┐
│ Collect Payment         ×   │  ← App Bar
├─────────────────────────────┤
│ Customer                     │  ← Summary (deep purple bg)
│ Rajesh Kumar                 │
│ Outstanding: ₹16,500 (red)   │
├─────────────────────────────┤
│ Amount                       │  ← Form fields
│ ┌─────────────────────────┐ │
│ │ ₹ [_____________]       │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ Payment Mode                 │
│ ┌──────┐ ┌──────┐ ┌──────┐ │  ← Segmented buttons
│ │ Cash │ │ UPI  │ │ Card │ │
│ └──────┘ └──────┘ └──────┘ │  (Cash selected by default)
├─────────────────────────────┤
│ Note (Optional)              │
│ ┌─────────────────────────┐ │
│ │ [_________________]     │ │  ← Multi-line input
│ │ [_________________]     │ │
│ │ [_________________]     │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │  ← Error/Success message
│ │ ✓ Payment recorded!     │ │     (if shown)
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │
│ │  CONFIRM PAYMENT   [⟳]  │ │  ← CTA button (loading state)
│ └─────────────────────────┘ │
│                              │
└─────────────────────────────┘
```

### Interactions
- **Amount Field**: Numeric input only
- **Mode Selector**: Toggle between Cash/UPI/Card
- **Confirm Button**: Disable while submitting, show spinner
- **Note Field**: Optional, multi-line text
- **Back**: Cancel (discard form)

### States
- **Loading**: Button shows spinner, disabled
- **Success**: Green checkmark message + auto-return to detail
- **Offline**: Orange message "Saved offline. Will sync when connected"
- **Error**: Red error message with specific error text

---

## Screen 4: Add Customer Form

### Layout
```
┌─────────────────────────────┐
│ Add Customer            ×   │  ← App Bar
├─────────────────────────────┤
│ Customer Name *              │  ← Mandatory field label
│ ┌─────────────────────────┐ │
│ │ [Enter full name]       │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ Phone Number *               │
│ ┌─────────────────────────┐ │
│ │ +91 [10-digit number]   │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ▼ Advanced Information       │  ← Collapsible toggle
├─────────────────────────────┤
│ Email Address                │  ← Shown when expanded
│ ┌─────────────────────────┐ │
│ │ [customer@example.com]  │ │
│ └─────────────────────────┘ │
│                              │
│ Address                      │
│ ┌─────────────────────────┐ │
│ │ [Full address here]     │ │
│ │ [Multi-line]            │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │  ← Error message (if any)
│ │ ✕ Please enter name     │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │
│ │     ADD CUSTOMER        │ │  ← CTA button
│ └─────────────────────────┘ │
│                              │
└─────────────────────────────┘
```

### Interactions
- **Mandatory Fields**: Name, Phone (red asterisk marker)
- **Advanced Toggle**: Expand/collapse for optional fields
- **Phone Field**: Formatted input (leading +91)
- **Add Button**: Validate on client before submit
- **Back**: Cancel (discard form)

### States
- **Loading**: Button disabled, shows spinner
- **Success**: Toast message + return to list
- **Offline**: Saved locally message + return to list
- **Error**: Red error message with validation errors

---

## Navigation Flow

```
┌─────────────────┐
│  Customer List  │  (Home)
│   (All search)  │
└────────┬────────┘
         │ Tap customer / Refresh FAB
         │
    ┌────▼──────────┐
    │  Customer     │
    │  Ledger/      │
    │  Detail       │
    └────┬──────────┘
         │ Collect Payment / Back
         │
    ┌────▼──────────┐
    │  Payment      │
    │  Form         │ ← Success: auto-return to Detail
    └───────────────┘


         FAB (Add Customer)
         │
    ┌────▼──────────┐
    │  Add          │
    │  Customer     │
    └───────────────┘ ← Success: return to List
```

---

## Responsive Behavior

### Mobile (375px - 480px)
- **Customer List**: Full-width cards, search bar prominent
- **Payment Form**: Stack all fields vertically
- **Buttons**: Full-width, 48pt minimum height for touch

### Tablet (600px+)
- **Future**: Can show split view (list + detail side-by-side)
- Currently: Same as mobile (future enhancement)

---

## Accessibility Features

1. **High Contrast**: Red/Green for balance status (color + text labels)
2. **Touch Targets**: Minimum 48pt for buttons
3. **Labels**: All inputs have clear labels
4. **Icons**: Used with text labels (not icon-only)
5. **Loading States**: Spinner + disabled state clear
6. **Error Messages**: Large, red text, positioned prominently

---

## Animation & Transitions

- **Screen Transitions**: Material fade (100ms)
- **Button Press**: Ripple effect (Material standard)
- **Loading Spinner**: Standard circular progress indicator
- **Success Message**: Fade in (200ms) + fade out (500ms)

---

## Dark Mode Support (Future)

Currently light-only. To add dark mode:

```dart
// In main.dart theme config
darkTheme: ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.deepPurple[200],
  // ... dark colors
),
themeMode: ThemeMode.system, // Follow system preference
```

---

## Comparison with Web Design

| Aspect | Web (Ledger) | Mobile (Collection) |
|--------|---|---|
| Layout | Multi-panel (sidebar + content) | Full-screen, drill-down |
| Search | Global (all screens) | Home screen only |
| Balance Display | Summary cards (Cash In, Out, Net) | Customer header + ledger |
| Payment | Embedded form in main view | Separate fullscreen form |
| Navigation | Sidebar tabs | Bottom-up stack |

---

## Design Tokens

```dart
// lib/constants/design_tokens.dart
class DesignTokens {
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  
  // Corner radius
  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  
  // Font sizes
  static const double fontXS = 12;
  static const double fontS = 14;
  static const double fontM = 16;
  static const double fontL = 18;
  
  // Touch target minimum
  static const double touchTargetMin = 48;
}
```

---

End of Design Document
